import testr

class ExecResult:
	""" Contains the result of the execution on the target. Each test result knows the target it ran on, the overall result of the execution (whether the execution passed or failed), the time it took, measured by the framework (that is including the target startup time), the return code of the execution,  and the stdout and stderr values of the execution (the stdout and stderr values should be stripped of target specific values, that is they should only contain the text produced as a direct result of the test execution.
   
	Specific targets may support additional items in the test result, like for example the time measured by the VM itself, that is excluding the VM startup, and so on. 
    """
	# target execution was a pass, that means the target did startup, executed the test and returned 0 as its result status
	PASS = 0
	# target execution was a failure, that is the target did not start up properly
	FAIL = -1
	# target execution was terminated due to too long execution
	TIMEOUT = "TIMEOUT"
    # the execution should be retried
	RETRY = "retry"


	def __init__(self, target, result, time, retCode, stdout, stderr, **kwargs):
		""" Initializes the test result with all required arguments and potential specific arguments for the target listed as keyword arguments. """
		self.target = target
		self.result = result
		self.time = time
		self.returnCode = retCode
		self.stdout = stdout
		self.stderr = stderr
		for k in kwargs:
			setattr(self, k, kwargs[k])


class BaseTarget:
	""" Basic class for all targets known to the testR framework. Each new target must inherit from this class (that is provide at least the functionality described here. """

	def __init__(self):
		""" Initializes the target, that is sets its path to the default path and its arguments to the default arguments. 
	   
	    Call the inherited __init__ method also from specific targets. """
		self.path = self.defaultPath()
		self.cmdArguments = self.defaultCmdArguments()
		self._displayFullCommand = False

	def defaultPath(self):
		""" Returns the default path of the target, which will be used if no other path is specified. This method must be overriden in subclasses of specific targets. """
		testr.fatalError("Target.defaultPath() must be overriden for specific targets")

	def defaultCmdArguments(self):
		""" Returns the default arguments for the target. By default, these are empty."""
		return ()

	def name(self):
		""" Returns the name of the target. Each target must have a distinctive name which corresponds to its module name. """
		return self.__class__.__module__.split(".")[-1]
	
	def doParseArgument(self, name, value):
		""" Analyzes the given argument specified by its name and value. This method should return True if the argument is recognized and the value is correct, should return False if the argument is not recognized and should call the testr.fatalError function if the argument is recognized, but the value is not recognized.
	   
		Override this method while calling the inherited one to provide new functionality. 
	    """
		if (name in ("path", "p")):
			testr.writeln("  path changed to {0}".format(value))
			self.path = value
		elif (name in ("arg", "a")):
			if (self.cmdArguments == self.defaultCmdArguments()):
				self.cmdArguments = [value,]
			else: # multiple default arguments can be concatenated
				self.cmdArguments.append(value)
		elif (name in ('displayCmd', 'dc')):
			self._displayFullCommand = True if value else False
		else:
			return False
		return True


	def parseArguments(self, args):
		""" Parses argument for the target. Target arguments must appear on the command line right after the target specification (--target=). Analyzes all arguments up to the first argument that is not understood by the current target (method _parseArgument() returns False).
	   
	   DO NOT OVERRIDE THIS METHOD, override the functionality provided in doParseArgument() and do not forget to call the old method.  """
		state = 0
		i = 0
		while (i < len(args)):
			arg = args[i]
			if (state == 0):
				i += 1
				if ((arg[0] in ("target","t")) and (arg[1] == self.name())):
					state = 1
				continue
			if (not self.doParseArgument(arg[0], arg[1])):
				break
			args.pop(i)

	def initialize(self):
		testr.writeln("initializing target {0}".format(self.name()))
		pass

	def finalize(self):
		pass


	def _exec(self, cmd, args = (), input = None, timeout = 600):
		if (self._displayFullCommand):
			testr.writeln(self.name()+": "+self.path+" "+" ".join(args))
		return cmd.run(args,input,timeout)

	def exec(self, test):
		""" Runs the given test on the target and returns an ExecResult object.
	   
		Override this method to provide the target functionality. 
	    """
		testr.fatalError("exec() method must be overriden in target {0}".format(self.name()))

	def execResultFields(self):
		""" Returns a tuple containing names of fields in the ExecResult field that are supported by the given target. By default returns the arguments being parts of the Execresult object statically. The dynamic arguments specific to separate targets should be added by the subclasses. """
		return ("target", "result", "time", "retCode", "stdout", "stderr")


	def _extractOutput(self, runOut):
		""" Returns only those lines correspondling to the output of the run. Skips all lines to the first prompt and then only displays those lines that do not start with either > (prompt) or + (prompt continuation). If your target does not follow this convention you may need to reqrite this method. """
		header = True
		result = ""
		for line in runOut.split("\n"):
			if (header):
				if ((len(line) > 0) and (line[0] == '>')):
					header = False
			else:
				if (len(line) == 0):
					result += "\n"
				elif (line[0] not in ('>', '+')):
					if (line[-1] == '\r'):
						line = line[:-1]
					result += line + "\n"
		return result.strip()

	def vectorSkipWhitespaceDecoder(self, output):
		""" Given the output, it transforms it to a single vector of all values contained in it separated by space and no other whitespace characters anywhere between them. """
		result = ""
		lastWhitespace = False
		insideBrackets = False
		for c in output:
			if (c in ('[','<')):
				insideBrackets = True
				continue
			if (insideBrackets):
				if (c in (']','>')):
					insideBrackets = False
				continue
			if (c in (' ','\n', '\t')):
				if (not lastWhitespace):
					result += " "
					lastWhitespace = True
			else:
				lastWhitespace = False
				result += str(c)
		return result.strip()

	def numberFormatter(self, output):
		""" Given the output, calls the vectorSkipWhitespace decoder and then looks at the output with all numbers being changed to a simple and unique representation. The "L" suffix is removed from integer numbers and any double number that is .0 is converted to an integer. """
		res = ""
		WHITESPACE = 0
		NUMBER = 1
		FRACTION = 2
		VALID_FRACTION = 3
		tokenStart = 0
		state = WHITESPACE
		i = 0
		for c in self.vectorSkipWhitespaceDecoder(output):
			if (state == WHITESPACE):
				if (c >= '0') and (c <= '9'):
					state = NUMBER
			elif (state == NUMBER):
				if (c == '.'):
					state = FRACTION
					tokenStart = i
				elif (c == 'L'): # skip the L after integer
					state = WHITESPACE
					continue 
				elif (c < '0') or (c > '9'):
					state = WHITESPACE
			elif (state == FRACTION):
				if (c > '0') and (c <= '9'):
					state = VALID_FRACTION
				elif (c != '0'):
					i = tokenStart
					res = res[:i]
					state = WHITESPACE
			elif (state == VALID_FRACTION):
				if (c < '0') or (c > '9'):
					state = WHITESPACE
			res = res + c
			i += 1
		if (state == FRACTION):
			res = res[:tokenStart]
		return res
