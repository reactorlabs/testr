import os

# ---------------------------------------------------------------------------------------------------------------------
# Test
# ---------------------------------------------------------------------------------------------------------------------

class Test:
	""" Defines the simplest test that can be run in testR. The test has only very few methods, notably the raw code and test name, both strings and the list of all commands that should be executed with the tests. """

	def code(self):
		""" Return the code of the test, that is the proper R code to be executed on the target. """
		raise NotImplementedError("Override in children!"); 
	
	def name(self):
		""" Returns the name of the test. Each test should have unique name can be used by the testR to carry information about regressions, etc. """
		raise NotImplementedError("Override in children!"); 

	def preRunCommands(self):
		""" Returns the list of commands (pure Python code) to be executed before the test is executed. This is an empty tuple by default. If any of these commands return false, the test will not be exected and would be reported as not applicable, not an error by the testR. These tests may for instance make sure that the target corresponds to certain value, or such. """
		return ()

	def postRunCommands(self):
		""" Returns the list of commands (pure Python code) to be executed after the test is executed on its output. It is an empty list by default too. All the commands return either true, or false and their result together determines whether the test passed or not. """
		raise NotImplementedError("Override in children!"); 

	def line(self):
		""" Returns the line of the source file on which the test is defined (the first #! line of the test, or the first line of the file, if it is the first test in the file. """
		raise NotImplementedError("Override in children!"); 

	def filename(self):
		""" Returns the filename in which the test is defined. """
		raise NotImplementedError("Override in children!"); 

	def commands(self):
		""" Returns the command lines of the actual test. """
		raise NotImplementedError("Override in children!"); 

	@staticmethod
	def enumerate(roots, recursive = True):
		""" Given the test roots and whether the enumeration is recursive, generates all tests that can be found or constructred from them. A root can either be a file in which case all tests inside the file will be executed, or a directory, in which case all files in the directory and possibly recursive will be analyzed for all tests they contain. """
		while (roots):
			root,prefix = roots.pop()
			if (not os.path.isdir(root)):
				for t in Test._enumerateInFile(root, prefix):
					yield t
			else:
				for item in os.listdir(root):
					item = os.path.join(root,item)
					if (os.path.isdir(item)):
						if (recursive):
							roots.append((item,prefix))
					else:
						if (item[-2:] not in (".r", ".R")):
							continue 
						# it is an R file, analyze it
						for t in Test._enumerateInFile(item, prefix):
							yield t

	@staticmethod
	def _enumerateInFile(filename, prefix):
		""" Enumerates all tests in given file. """
		tp = TestParser(filename, filename[len(prefix)+1:])
		for test in tp.tests():
			yield test

# ---------------------------------------------------------------------------------------------------------------------
# SimpleTest
# ---------------------------------------------------------------------------------------------------------------------

class SimpleTest(Test):
	""" Simple test that does not store its code or commands, but takes everything from the test parser it is associated with. This test is used for not-gnerics tests. """

	def __init__(self, testParser):
		self._tp = testParser

	def code(self):
		return self._tp._code

	def name(self):
		return self._tp._name

	def preRunCommands(self):
		return self._tp._preRun

	def postRunCommands(self):
		return self._tp._postRun

	def line(self):
		return self._tp._line

	def filename(self):
		return self._tp._filename

	def commands(self):
		return self._tp._commandLines

# ---------------------------------------------------------------------------------------------------------------------
# GenericTest
# ---------------------------------------------------------------------------------------------------------------------

class GenericTest(Test):
	""" Test that remembers its own code and checks, because due to the generics these are different than the still templated code & checks in the associated test parser. """

	def __init__(self, testParser, code, commands, preBuildTests, postBuildTests):
		self._tp = testParser
		self._code = code
		self._commands = commands
		idxs = []
		for g in self._tp._genericOrder:
			idxs.append(str(g._idx))
		self._name = self._tp._name + " [{0}]".format(" ".join(idxs))
		self._pre = preBuildTests
		self._post = postBuildTests

	def code(self):
		return self._code

	def name(self):
		return self._name

	def preRunCommands(self):
		return self._pre

	def postRunCommands(self):
		return self._post

	def line(self):
		return self._tp._line

	def filename(self):
		return self._tp._filename

	def commands(self):
		return self._commands

# ---------------------------------------------------------------------------------------------------------------------
# TestParser
# ---------------------------------------------------------------------------------------------------------------------

class TestParser:
	""" This class is responsible for parsing and generating the tests from a single file. The file can have multiple tests, or a single test and each test can be templated to produce multiple raw code tests.  """

	DEFAULT_DECODER = "numberFormatter"

	def __init__(self, filename, name = False):
		""" Creates the test parser and initializes it to parse from the given filename. """
		self._filename = filename
		self._f = open(filename,"r")
		self._baseName = name if (name) else filename;
			


	def tests(self):
		""" Generator that returns all the tests present in the given file. """
		i = 1
		for commands, code, line in self._readTests():
			# now analyze the commands and the code, specifically, build the template lists
			self._line = line
			self._name = False
			self._generics = {}
			self._genericOrder = []
			self._genericPossibilities = 1
			self._preRun = []
			self._postRun = []
			self._code = "\n".join(code)
			self._checkedOutput = False
			self._commandLines = commands
			# set the decoder to its default 
			self._decoder = TestParser.DEFAULT_DECODER
			# for each command, parse it without the leading #!
			for cmd in commands:
				self._parseCommand(cmd[2:])
			# inject t command if we have no tests
			if (not self._postRun):
				self._parseCommand("t")
			elif (not self._checkedOutput):
				self._parseCommand("o TRUE")
			# if no name was specified, use the test filename + indes of the test in file
			if (not self._name):
				self._name = "{0} ({1})".format(self._baseName, str(i))
			i = i + 1
			# check if generics are in use
			if (self._genericPossibilities == 1):
				yield SimpleTest(self)
			else:
				# enumerate all nondependent generics in order
				gens = []
				for g in self._genericOrder:
					if (not g.dependsOn):
						gens.append(g)
				# now increment the indices
				while (True):
					c = self._code
					pre = []
					post = []
					cmds = []
					for g in self._genericOrder:
						c = c.replace("@{0}".format(g.name),g.value().replace("\\\\","\\").replace('\\"','"'))
					for cmd in self._preRun:
						for g in self._genericOrder:
							cmd = cmd.replace("@{0}".format(g.name),g.value())
						pre.append(cmd)
					for cmd in self._postRun:
						for g in self._genericOrder:
							cmd = cmd.replace("@{0}".format(g.name),g.value())
						post.append(cmd)
					for cmd in commands:
						for cc in self._genericOrder:
							cmd = cmd.replace("@{0}".format(cc.name),cc.value())
						cmds.append(cmd)
					yield GenericTest(self, c, cmds, pre, post)
					if (TestParser._incrementGenerics(gens)):
						break

	@staticmethod
	def _incrementGenerics(gens):
		""" Increments the generics. Returns true when overflow """
		for j in range(len(gens)-1,-1,-1):
			if (not gens[j].next()):
				return False
		return True

	def _readTests(self):
		""" Generator that reads all tests in the file and returns them as a tuple of test lines and then command lines for each test. The file always starts with a test, which may consist of 0 or N consecutive commands and 0 or N test lines. Commands are lines prefixed with #! which happens to be comment in R. After a non-command line is found after command lines in test, the next found command line will start the new test. Thus the simplest way of putting more tests into single file is to space them with an empty command #!. """
		code = []
		commands = []
		lastCommand = True
		lineCount = 0
		startLine = 1
		for line in self._f:
			lineCount += 1
			line = line.strip()
			if (not line):
				continue # skip empty lines
			if (line.find("#!#") == 0):
				continue # skip framework comments
			if (line.find("#!") == 0):
				if (lastCommand): # if commands are one after another, chain them
				    commands.append(line)
				else: # otherwise it is a new test, yield the one we have parsed and start a new one
					yield (commands, code,startLine)
					startLine = lineCount
					code = []
					commands = [line,]
					lastCommand = True
			else: # we are no longer parsing commands, but the test lines
				lastCommand = False
				code.append(line)
		if (code or commands): # if we have either commands, or test lines left, yield the last test
			yield (commands, code, startLine)
		self._f.close()

	def _parseCommand(self, cmd):
		""" Parses the given command and """
		if (not cmd): # empty command does nothing
			return
		# parse into command name and command arguments
		x = cmd.split(" ",1)
		cmd = x[0]
		args = x[1].strip().replace('"','#@?!').replace('\\','\\\\').replace("#@?!",'\\"') if (len(x) >1) else False
		self.parseCommand(cmd, args)

	def parseCommand(self, cmd, args):
		""" Parses the given command and its arguments. Based on the command and its argument decodes it and creates the appropriate pre and post build commands. Currently, the following commands are known to the system with the following meanings:

		#!b xxx -- evaluates the check xxx (python code) before the test is execute (pre run commands)
		#!a xxx -- evaluates the check xxx (python code) after the test is executed (post run commands)
		#!w xxx -- checks for the stderr of the test if it contains "xxx" as a warning. if xxx is empty, checks that no warnings are present
		#!e xxx -- checks for the stderr of the test if it contains "xxx" as an error and that the test was not successful
		#!o xxx -- tests the output for xxx
		#!d xxx -- sets the given decoder, default is vectorSkipWhitespaceDecoder 
		#!t xxx -- tests that the outputis XXX and that there were no warnings produced. If XXX is none, then XXX is TRUE
	    """

		if (args):
			if (not cmd):
				self._name = args;
			elif (cmd == "b"):
				self._preRun.append(args)
			elif (cmd == "a"):
				self._postRun.append(args)
			elif (cmd == "w"):
				self._postRun.append("assertWarning(error,\"%s\")" % args)
			elif (cmd == "e"):
				self._postRun.append("assertError(error,\"%s\")" % args)
				self._checkedOutput = True
			elif (cmd == "o"):
				self._postRun.append("assertOutput(self.target.%s(output), \"%s\")" % (self._decoder, args))
				self._checkedOutput = True
			elif (cmd == "oe"):
				self._postRun.append("assertOutput(self.target.%s(output), \"%s\", False)" % (self._decoder, args))
				self._checkedOutput = True
			elif (cmd == "de"):
				self._decoder = args
			elif (cmd == "t"):
				self._postRun.append("assertNoWarning(error)")
				self._postRun.append("assertOutput(self.target.%s(output), \"%s\")" % (self._decoder, args))
				self._checkedOutput = True
			elif (cmd == "te"): # test exact
				self._postRun.append("assertNoWarning(error)")
				self._postRun.append("assertOutput(self.target.%s(output), \"%s\", False)" % (self._decoder, args))
				self._checkedOutput = True
			elif (cmd == "tt"):
				args = ("TRUE " * int(args))[:-1]
				self._postRun.append("assertNoWarning(error)")
				self._postRun.append("assertOutput(self.target.%s(output), \"%s\")" % (self._decoder, args))
				self._checkedOutput = True
			elif (cmd == "tte"):
				args = ("TRUE " * int(args))[:-1]
				self._postRun.append("assertNoWarning(error)")
				self._postRun.append("assertOutput(self.target.%s(output), \"%s\", False)" % (self._decoder, args))
				self._checkedOutput = True
			elif (cmd == "g"):
				self._parseGeneric(args)
			elif (cmd == "d"):
				print("appending "+args)
				self._preRun.append('"'+args+'"')
			else:
				print("Unknown command %s with arguments %s" % (cmd, args))
		else: # no args 
			if (cmd == "w"):
				self._postRun.append("assertNoWarning(error)")
			elif (cmd == "e"):
				self._postRun.append("assertError(error)")
				self._checkedOutput = True
			elif (cmd == "t"):
				self._postRun.append("assertNoWarning(error)")
				self._postRun.append("assertOutput(self.target.%s(output), \"TRUE\")" % self._decoder)
				self._checkedOutput = True
			elif (cmd == "te"):
				self._postRun.append("assertNoWarning(error)")
				self._postRun.append("assertOutput(self.target.%s(output), \"TRUE\", False)" % self._decoder)
				self._checkedOutput = True
			elif (cmd == "ttt"):
				self._postRun.append("assertNoWarning(error)")
				self._postRun.append("assertOutputIsOnlyTrue(self.target.%s(output))" % self._decoder)
				self._checkedOutput = True
			elif (cmd == "ttte"):
				self._postRun.append("assertNoWarning(error)")
				self._postRun.append("assertOutputIsOnlyTrue(self.target.%s(output), False)" % self._decoder)
				self._checkedOutput = True
			elif (cmd == "d"):
				self._preRun.append("\"Test is disabled\"")
			else:
				print("Unknown command %s. Maybe arguments are missing" % cmd)

	def _parseGeneric(self, cmd):
		""" Parses the command for creating generics in the tests. """
		cmd = cmd.split("=", 1)
		if (len(cmd) == 1):
			error("Generic command {0} does not specify its values".format(cmd[0]))
		# parse the value to list of strings
		values = [ i.strip() for i in cmd[1].strip()[1:-1].split("#") ]
		cmd = cmd[0].strip()
		cmd = cmd.split("(",1)
		if (len(cmd)==1):
			# independent generic
			self._genericPossibilities = self._genericPossibilities * len(values)
			gen = GenericArgument(cmd[0],values)

		else:
			dep = cmd[1]
			if (dep[-1] != ")"):
				error("Invalid syntax for dependent generic {0}".format(cmd[0]))
			dep = dep[:-1]
			if (dep not in self._generics):
				error("Dependent generic {0} dependency {1} not found. Must be declared beforehand.")
			gen = GenericArgument(cmd[0],values)
			self._generics[dep].addDependentArgument(gen)
			gen.dependsOn = dep
		self._generics[cmd[0]] = gen
		self._genericOrder.append(gen)

# ---------------------------------------------------------------------------------------------------------------------
# GenericArgument
# ---------------------------------------------------------------------------------------------------------------------

class GenericArgument:
	""" Simple holder for the generic argument. Remembers list of all values, current value, all dependent arguments and any argument this one depends on. """

	def __init__(self, name, values, dependsOn = False):
		""" Creates the argument as an independent argument with given name and values. Initializes to its first value. """
		self.name = name
		self.values = values
		self._idx = 0
		self.dependants = []
		self.dependsOn = dependsOn

	def addDependentArgument(self, generic):
		""" Adds a new argument to the list of arguments that depend on this argument. """
		self.dependants.append(generic)

	def value(self):
		""" Returns the value of the argument, converted to string. """
		return str(self.values[self._idx])

	def next(self):
		""" Moves to next value in the list. Returns true if there is such value, returns false on overflow, when it again starts with the first value specified. """
		self._idx += 1
		for gen in self.dependants:
			gen.next()
		if (self._idx == len(self.values)):
			self._idx = 0
			return True
		return False
