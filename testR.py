import time
import sys
import os

from command import Command
from checks import *
from tests import Test
from target import BaseTarget

# testR - R testing suite


# ---------------------------------------------------------------------------------------------------------------------
# simple helper functions
# ---------------------------------------------------------------------------------------------------------------------

def strFormat(what,size = 80):
	""" Returns the given string formatted to given characters, if the string is not displayed completely a ... is prepended and the end of the string is returned. """
	r = ("{0:"+str(size)+"}").format(what)
	if (len(r) > size):
		r = "..."+r[-77:]
	return r

def strLineOffset(what, offset = 4):
	""" Offsets each line in the specified text with given ammount of spaces. """
	lines = what.split("\n")
	res = ""
	for l in lines:
		l = l.strip()
		if (l):
			res = res + (" "*offset + l + "\n")
	return res

def error(msg):
	""" Displays the error message and then exits the application. """
	print(msg)
	sys.exit(1)

# ---------------------------------------------------------------------------------------------------------------------
# TestR
# ---------------------------------------------------------------------------------------------------------------------

class TestR:
	""" Basic clas for the testing. Runs all tests using the test generator and for each test produces the report. """
	DEFAULT_TARGET = "gnur"
	TARGETS = ("gnur", "fastr")
	OK = "OK"
	RUN_FAIL = "RUN_FAIL"
	TEST_FAIL = "FAIL"
	NOT_RUN = "SKIPPED"

	def __init__(self, argv):
		""" Initializes the testR with given command line arguments. """
		self._verbose = False
		self._target = TestR.DEFAULT_TARGET
		self._targetPath = False
		self._recursive = False
		self._reportOnlyErrors = False
		self._testRoots = []
		self._plainROutput = None
		self._parseArguments(argv)
		if (not self._testRoots):
			self._testRoots.append((os.getcwd(), os.getcwd()))

	def run(self):
		""" Runs the test suite as specified, that is runs all tests in all files under all test roots. """
		if (self._plainROutput != None):
			return self._runPlainR()
		self._print("Initializing target %s " % self._target)
		self.target = __import__(self._target).Target(self._targetPath)
		self._print("    path:         %s" % self.target.path)
		self._print("    version:      %s" % self.target.version)
		self._print("    architecture: %s" % self.target.arch)
		tests = 0
		test_fails = 0
		run_fails = 0
		skipped = 0

		for t in Test.enumerate(self._testRoots, self._recursive):
			if (not self._reportOnlyErrors):
				print(strFormat(t.name()), end="")
			result = self._runTest(t)
			if (self._reportOnlyErrors):
				if (result[0] in (TestR.RUN_FAIL, TestR.TEST_FAIL)):
					print(strFormat(t.name()), end="")
					print(result[0])
			else:
					print(result[0])
			if (result[0] in (TestR.RUN_FAIL, TestR.TEST_FAIL)):
				print("    File: {0} [line {1}]".format(t.filename(), t.line()))
				print(strLineOffset(result[1]))
				self._print("    Code:")
				self._print(strLineOffset(t.code(), 8))
			tests += 1
			if (result[0] == TestR.RUN_FAIL):
				run_fails += 1
			elif (result[0] == TestR.TEST_FAIL):
				test_fails += 1
			elif (result[0] == TestR.NOT_RUN):
				skipped += 1

		print("\n----------------------------------------------------------------------------------------------------------\n")
		print("Total tests:    {0}".format(tests))
		print("Skipped:        {0}".format(skipped))
		print("Successful:     {0} {1}".format(tests-test_fails-run_fails-skipped, "OK" if (test_fails + run_fails == 0) else "FAIL"))
		print("Failed:         {0}".format(run_fails + test_fails))
		print("    execution:  {0}".format(run_fails))
		print("    checks:     {0}".format(test_fails))

	def _runPlainR(self):
		""" Runs the tester in plain R mode, where it outputs the plain R version of the tests to a special file, rather than running the tests. """
		if (len(self._testRoots)!=1):
			error("When using --plainr mode, only one root can be selected");
		root = self._testRoots[0][0]
		lastFilename = ""
		outfile = None
		fileTests = 0
		print("Creating R-compatible raw tests. The following is a list of test file entered")
		print("and number of tests generated:\n")
		for t in Test.enumerate(self._testRoots, self._recursive):
			if (t.filename() != lastFilename):
				if (outfile != None):
					print("["+str(fileTests)+"]")
					outfile.close()
					fileTests = 0
				fname = os.path.join(self._plainROutput, t.filename()[len(root)+1:])
				dirname, filename = os.path.split(fname)
				print(strFormat(fname), end="")
				os.makedirs(dirname, exist_ok = True)
				outfile = open(fname, "w")
				lastFilename = t.filename()
			for c in t.commands():
				if (c.find("#! ") == 0):
					outfile.write("#! "+t.name()+"\n")
				elif (c.find("#!g") == 0):
					pass
				else:
					outfile.write(c.replace("\\\"",'"')+"\n")
			outfile.write(t.code()+"\n\n")
			fileTests += 1
		if (outfile != None):
			print("["+str(fileTests)+"]")
			outfile.close()


	def _runTest(self, test):
		""" Runs the given test on the target associated with the test analyzer. In any case returns a tuple with its first element being the result of the test. Runs the pre run commands and if any of them fails returns the NOT_RUN status and the failing command. Then runs the test code and upon failure returns a tuple RUN_FAIL, return code of the target and the stdout and stderr captures of the execution. Then runs all the post run commands (checks) and if any of them fails, returns a tuple containing the TEST_FAIL status, the failed check and stdout and stderr of the R execution. Finally if all post run checks pass, returns the OK status followed by the execution time of the test. The returned tuple is injected with empty strings if its length is less than 4. """
		# TODO UPDATE HELP
		for cmd in test.preRunCommands():
			msg = eval(cmd)
			if (msg):
				return (TestR.NOT_RUN, msg, "", "")
		result = self.target.run(test.code())
		if (result[3] == BaseTarget.FEATURE_NOT_IMPLEMENTED):
			return (TestR.NOT_RUN, result[0], "", "")
		output = self.target.extractOutput(result)
		error = result[Command.STD_ERR]
		if (result[Command.RETURN_CODE] != Command.SUCCESS and not output and not error):
			return (TestR.RUN_FAIL, "Target exitted with returrn code {0}".format(result[Command.RETURN_CODE]), output, error)
		for cmd in test.postRunCommands():
			msg = eval(cmd)
			if (msg):
				return (TestR.TEST_FAIL, msg, output, error)
		return (TestR.OK, result[Command.EXEC_TIME], "", "")


	def _print(self, what):
		""" Prints if verbose, does nothing otherwise. """
		if (self._verbose):
			print(what)

	def _parseArguments(self, argv):
		""" Parses the arguments for the testR. """
		for arg in argv[1:]:
			arg = arg.split("=",1)
			val = arg[1] if (len(arg)>1) else False
			arg = arg[0]
			# get rid of quotes in the value, if any
			if (val):
				if ((val[0] == val[-1]) and (val[0] in ("'",'"'))):
					val = val[1:-1] 
			# decode the argument
			if (arg in ("--verbose", "-v")):
				self._verbose = True
			elif (arg in ("--target", "-t")):
				if (val not in self.TARGETS):
					error("Unknown target %s, possible values are: %s" % (val, ", ".join(self.TARGETS)))
				self._target = val
			elif (arg in ("--targetPath", "-tp")):
				self._targetPath = val;
			elif (arg in ("--recursive", "-r")):
				self._recursive = True
			elif (arg in ("--reportOnlyErrors", "-roe")):
				self._reportOnlyErrors = True
			elif (arg in ("--help", "-h")):
				printHelp()
			elif (arg in ("--plainr", "-pr")):
				self._plainROutput=val;
			else:
				if (arg[0] == '-'):
					error("Invalid argument %s" % arg)
				if ((arg[0] == arg[-1]) and (arg[0] in ("'",'"'))):
					arg = arg[1:-1] 
				self._testRoots.insert(0, (arg,arg))




def printHelp():
	""" Prints help for the testR framework and then exits. """
	print("""
testR framework (beta)
======================

Beta means that this list of arguments, or this help is by no means complete, or should be trusted. Always check the code:)

Usage:

python testR.py [arguments] [root test locations]

Where:

Root test locations are system paths (to a file, or a directory) which will be
scanned for the tests to execute. The tests will be executed from these
locations in order. 

Arguments are arguments to the testR framework and they can be one of the
following:

--verbose (or -v) enables verbose printing
--target= (or -t=) specifies the target VM (see below) to run the tests on 
--targetPath= (or -tp=) specifies the path to the target
--recursive (or -r) means that the roots of tests (if they are directories)
    will be recursively searched for R files
--reportOnlyErrors (or -roe) means that only tests that fail will be
    reported - by default all tests are shown so that progress can be
	tracked
--help (or -h) displays this message and exists
--plainr= (or -pr=) creates for each file of tests it reads in the corresponding
  directory a file containing the raw R output of  

Known Targets:
	""")
	print(", ".join(TestR.TARGETS))
	sys.exit(0)


def execute():
	args = sys.argv
	if (len(sys.argv) == 1):
		# make sure we have at least the default arguments selected
		#args = ("","--target=gnur","--verbose","--recursive","language tests") 
		args = ("","--target=gnur","--verbose","--recursive","language tests/data types/array/subset matrix.r") 
		#args = ("","--target=fastr","--verbose","--recursive","language tests") 
	t = TestR(args)
	t.run()




if (__name__=="__main__"):
	execute()
	# TODO this is only for debugging, remove when I am done with the infrastructure
	input("press enter to continue")


