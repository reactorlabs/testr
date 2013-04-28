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
			self.reset(None)
			
		def reset(self, test):
			self.lastTest = test
			self.target = None # target name
			self.midx = 0 # measurement idx
			self.ttime = 0 # total time as reported by the testR
			self.ttimeVm = 0 # total time as reported by the VM (if present)
			self.results = [] # results for different targets

	""" Basic module interface to be implemented by all modules. A module is a piece of code that is used to analyze every test on every target. """
	def __init__(self):
		super().__init__()
		self._lock = threading.Lock()
		self._measurements = 10

	def initialize(self, targets):
		testr.writeln("  initializing module timer")
		if (not targets):
			testr.fatalError("module timer must have at least one target specified")
		self.count = 0
		self._tlocal = Module.TL()
		self._longestTargetName = max([ len(i.name()) for i in targets])
		self.write(testr.truncIfLonger("test name",70))
		for t in targets:
			self.write(" | {0:17}".format(t.name()))
		self.writeln("")
		

	def doParseArgument(self, name, value):
		if (not super().doParseArgument(name, value)):
			if (name in ("measurements","m")):
				self._measurements = int(value)
			else:
				return False
		return True

	def analyze(self, test, execResult):
		target = execResult.target
		tl = self._tlocal
		# if it is a new test, increase the count of the tests
		if (test != tl.lastTest):
			with (self._lock):
				self.count += 1
				if (tl.lastTest != None):
					self.write(testr.truncIfLonger(tl.lastTest.name(),70))
					for r in tl.results:
						if (len(r) == 1):
							self.write(" | {0:8f}         ".format(r[0]))
						else:
							self.write(" | {0:8f} {1:8f}".format(r[0],r[1]))
				self.writeln("")
			tl.reset(test)
		tl.ttime += execResult.time
		if (hasattr(execResult,"vmTime")):
			tl.ttimeVm += execResult.vmTime
		tl.midx += 1
		if (tl.midx < self._measurements):
			return ExecResult.RETRY
		else:
			if (tl.ttimeVm != 0):
				tl.results.append((tl.ttime / self._measurements, tl.ttimeVm / self._measurements))
			else:
				tl.results.append((tl.ttime / self._measurements,))

						  

	def finalize(self):
		pass
		


