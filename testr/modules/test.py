import testr
from . import BaseModule
import threading
from targets import ExecResult
from command import Command
from checks import *


class Module(BaseModule):

	class TL(threading.local):
		def __init__(self):
			super().__init__()
			self.lastTest = None
			self.tidx = -1

	""" Basic module interface to be implemented by all modules. A module is a piece of code that is used to analyze every test on every target. """
	def __init__(self):
		super().__init__()
		self._lock = threading.Lock()
		self._showOnlyErrors = False
		self._failAfterError = False
		self._showCodeOnError = False
		self._files = {}

	def initialize(self, targets):
		testr.writeln("  initializing module test")
		if (not targets):
			testr.fatalError("module test must have at least one target specified")
		self.count = 0
		self.passed = [0] * len(targets)
		self.failed = [0] * len(targets)
		self.execFailed = [0] * len(targets)
		self.skipped = [0] * len(targets)
		self._targets = targets
		self._tlocal = Module.TL()
		self._longestTargetName = max([ len(i.name()) for i in targets])
		

	def doParseArgument(self, name, value):
		if (not super().doParseArgument(name, value)):
			if (name in ("showOnlyErrors","soe")):
				self._showOnlyErrors = True if value else False
			elif (name in ("failAfterError","fae")):
				self._failAfterError = True if value else False
			elif (name in ("showCodeOnError","coe")):
				self._showCodeOnError = True
			else:
				return False
		return True

	def analyze(self, test, execResult):
		target = execResult.target
		# if it is a new test, increase the count of the tests
		if (test != self._tlocal.lastTest):
			with (self._lock):
				self.count += 1
			self._tlocal.lastTest = test
			self._tlocal.tidx = -1
		self._tlocal.tidx += 1
		if (self._targets[self._tlocal.tidx] != target):
			self._tlocal.tidx = 0
			while (self._targets[self._tlocal.tidx] != target):
				self._tlocal.tidx += 1
		# run the preconditions - if they fail, the test is marked as skipped
		for cmd in test.preRunCommands():
			msg = eval(cmd)
#			if (msg):
#				with (self._lock):
#					self.skipped[self._tlocal.tidx] += 1
#					self.writeln("SKIPPED Test {0} from file {1} skipped for target {2}:".format(test.name(), test.filename(), target.name()))
#					self.writeln("  {0}".format(msg))
#					self.markAsSkip(test)
#					return
		if (execResult.stderr.find("at r.")!=-1):
			execResult.result = "NOT IMPLEMENTED YET"
		if (execResult.stderr.find("at org.renjin.")!=-1):
			execResult.result = "NOT IMPLEMENTED YET"
		# check that the execution was a success
		if (execResult.result != ExecResult.PASS):
			with (self._lock):
				self.execFailed[self._tlocal.tidx] += 1
				self.writeln("FAILED  Test {0} from file {1} failed to execute for target {2}:".format(test.name(), test.filename(), target.name()), force = self._failAfterError)
				if (execResult.returnCode == ExecResult.TIMEOUT):
					self.writeln("  TIMEOUT", force = self._failAfterError)
				else:
					self.writeln("  {0}".format(execResult.result), force = self._failAfterError)
				if (self._failAfterError):
					testr.fatalError("Terminating after a test error.")
				self.markAsExecFail(test)
				return
		# check that the execution code is a success or a stderr or stdout are present
		output = execResult.stdout
		error = execResult.stderr
		if ((execResult.returnCode != Command.SUCCESS) and not output and not error):
			with (self._lock):
				self.failed[self._tlocal.tidx] += 1
				self.writeln("FAILED  Test {0} from file {1} failed to execute for target {2}:".format(test.name(), test.filename(), target.name()), force = self._failAfterError)
				if (execResult.returnCode == ExecResult.TIMEOUT):
					self.writeln("  TIMEOUT", force = self._failAfterError)
				else:
					self.writeln("  return code is {0} and no output or error given".format(execResult.returnCode), force = self._failAfterError)
				if (self._failAfterError):
					testr.fatalError("Terminating after a test error.")
				self.markAsFail(test)
				return
		# run the post condition checks
		for cmd in test.postRunCommands():
			msg = eval(cmd)
			if (msg):
				with (self._lock):
					self.failed[self._tlocal.tidx] += 1
					self.writeln("-------------------------------------------------------------------------------------------------", force = self._failAfterError)
					self.writeln("FAILED  Test {0} from file {1} failed to execute for target {2}:".format(test.name(), test.filename(), target.name()), force = self._failAfterError)
					self.writeln("  " + "\n  ".join([ i.rstrip() for i in msg.split("\n")]), force = self._failAfterError)
					self.writeln("  Output:", force = self._failAfterError)
					self.writeln("    " + "\n    ".join([ i.rstrip() for i in output.split("\n")]), force = self._failAfterError)
					self.writeln("  Error:", force = self._failAfterError)
					self.writeln("    " + "\n    ".join([ i.rstrip() for i in error.split("\n")]), force = self._failAfterError)
					if (self._showCodeOnError):
						self.writeln("  Code:", force = self._failAfterError)
						self.writeln("    " + "\n    ".join([i.rstrip() for i in test.code().split("\n")]), force = self._failAfterError)
					self.writeln("-------------------------------------------------------------------------------------------------", force = self._failAfterError)
					if (self._failAfterError):
						testr.fatalError("Terminating after a test error.")
					self.markAsFail(test)
					return
		# all done ok, write as success
		with (self._lock):
			self.passed[self._tlocal.tidx] += 1
			if (not self._showOnlyErrors):
				self.writeln("PASSED  Test {0} from file {1} passed for target {2}".format(test.name(), test.filename(), target.name()))
			self.markAsPass(test)

	def markAsFail(self, test):
		
		fn = "/".join(test.filename().split("/")[7:])
		if (fn not in self._files):
			self._files[fn] = [0,0,0,0]
		self._files[fn][2] += 1

	def markAsExecFail(self, test):
		fn = "/".join(test.filename().split("/")[7:])
		if (fn not in self._files):
			self._files[fn] = [0,0,0,0]
		self._files[fn][3] += 1

	def markAsSkip(self, test):
		fn = "/".join(test.filename().split("/")[7:])
		if (fn not in self._files):
			self._files[fn] = [0,0,0,0]
		self._files[fn][1] += 1

	def markAsPass(self, test):
		fn = "/".join(test.filename().split("/")[7:])
		if (fn not in self._files):
			self._files[fn] = [0,0,0,0]
		self._files[fn][0] += 1


	def finalize(self):
		for fn in self._files.keys():
			x = self._files[fn]
			self.writeln("%-50s %5s %5s %5s %5s %5s" % (fn, x[0], x[1], x[2], x[3], x[0] + x[1] + x[2] + x[3]))
		self.writeln("\n----- test module report -----\n", force = True)
		self.writeln("  target                             | passed | skipped | failed | exec failed", force = True)
		self.writeln("  ----------------------------------------------------------------------------", force = True)
		for i in range(len(self._targets)):
			self.writeln("  {0:34} | {1:6} | {2:7} | {3:6} | {4:11}".format(self._targets[i].name(), self.passed[i], self.skipped[i], self.failed[i], self.execFailed[i]), force = True)
		self.writeln("\n  Total tests: {0}".format(self.count), force = True)
		



