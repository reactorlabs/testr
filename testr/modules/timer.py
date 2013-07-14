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
			self.ttimeTmr = 0 # total time as reported by the timer 
			self.results = [] # results for different targets

	""" Basic module interface to be implemented by all modules. A module is a piece of code that is used to analyze every test on every target. """
	def __init__(self):
		super().__init__()
		self._lock = threading.Lock()
		self._measurements = 10
		self._timer=None

	def initialize(self, targets):
		testr.writeln("  initializing module timer")
		if (not targets):
			testr.fatalError("module timer must have at least one target specified")
		self.count = 0
		self._targets = targets
		self._tlocal = Module.TL()
		self._longestTargetName = max([ len(i.name()) for i in targets])
		self.write(testr.truncIfLonger("test name",70))
		for t in targets:
			self.write(" | {0:17}".format(t.name()))
		self.writeln("")
		self.writeln("-" * (70 + len(targets) * 20))
		

	def doParseArgument(self, name, value):
		if (not super().doParseArgument(name, value)):
			if (name in ("measurements","ms")):
				self._measurements = int(value)
			elif (name in ("timer","tmr")):
				self._timer = value
			else:
				return False
		return True

	def analyze(self, test, execResult):
		target = execResult.target
		tl = self._tlocal
		tl.ttime += execResult.time
		if (self._timer != None):
			for line in execResult.stdout.split("\n"):
				line = line.strip()
				if (line.find("__TIMER__")==0):
					l = line.split(" ",2)
					if (l[2] == self._timer):
						tl.ttimeTmr += float(l[1])/1000
		tl.midx += 1
		if (tl.midx < self._measurements):
			return ExecResult.RETRY
		else:
			tl.midx = 0 # reset the measurements
			with (self._lock):
				if (tl.ttimeTmr != 0):
					tl.results.append((tl.ttime / self._measurements, tl.ttimeTmr / self._measurements))
				else:
					tl.results.append((tl.ttime / self._measurements,))
				tl.ttime = 0
				tl.ttimeTmr = 0
				if (len(tl.results) == len(self._targets)):
					self.write(testr.truncIfLonger(test.name(),70))
					for r in tl.results:
						if (len(r) == 1):
							self.write(" | {0:8f}         ".format(r[0]))
						else:
							self.write(" | {0:8f} {1:8f}".format(r[0],r[1]))
					self.writeln("")
					self.count += 1
					tl.reset(test)

						  

	def finalize(self):
		pass
		


