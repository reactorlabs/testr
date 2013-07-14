import testr
from . import BaseModule
import threading


class Module(BaseModule):
	""" Basic module interface to be implemented by all modules. A module is a piece of code that is used to analyze every test on every target. """
	def __init__(self):
		super().__init__()
		self._lock = threading.Lock()
		self._files = {}

	def initialize(self, targets):
		testr.writeln("  initializing module counter")
		if (targets):
			testr.fatalError("  module counter can only be used with no targets")
		self.count = 0

	def analyze(self, test, execResult):
		with self._lock:
			self.count += 1
			fn = "/".join(test.filename().split("/")[7:-1])
			if (fn not in self._files):
				self._files[fn] = 0
			self._files[fn] += 1

	def finalize(self):
		for fn in self._files.keys():
			self.writeln("%-120s %s" % (fn, self._files[fn]))
		self.writeln("\n----- counter module report -----\n", force = True)
		self.writeln("  Total {0} tests found.".format(self.count), force = True)

