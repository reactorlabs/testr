from . import BaseTarget, ExecResult

import command
import testr

class Target(BaseTarget):
	""" GNU R target. """

	def __init__(self):
		super().__init__()

	def _arguments(self):
		return ("--arch", "32", " --vanilla")

	def defaultCmdArguments(self):
		return ()

	def defaultPath(self):
		return "c:/Program Files/R/R-3.0.0/bin/R.exe"

	def initialize(self):
		super().initialize()
		try:
			self.command = command.Command(self.path)
			v = self.command.run(args= self._arguments() + ("--version",))
			print(v[1])
			v = v[1].split("\n") if command._isWindows else v[0].split("\n")
			self.version = v[0].strip().split(" ")[2]
			if (self.version[0] == "3"):
				self.arch = v[2].strip().split(" ")[1]
			else:
				self.arch = v[3].strip().split(" ")[1]
			testr.writeln("Target R initialized:")
			testr.writeln("  arch:    {0}".format(self.arch))
			testr.writeln("  version: {0}".format(self.version))
			testr.writeln("  path:    {0}".format(self.path))  
		except IOError:
			testr.fatalError("Target path {0} not found!".format(self.path))

	def exec(self, test):
		""" Runs the given test on the target and returns an ExecResult object. """
		try:
			stdout,stderr,rc,time = self._exec(self.command, args = self._arguments() + self.cmdArguments, input = test.code())
			if (time == "TIMEOUT"):
				return ExecResult(self,ExecResult.TIMEOUT,0,0,"","")
			# the execution was a success, clean the output
			stdout = self._extractOutput(stdout)
			# return the exec result with no additional values
			return ExecResult(self, ExecResult.PASS, time, rc, stdout, stderr)

		except:
			return ExecResult(self,ExecResult.FAIL, 0, 0, "", "")

