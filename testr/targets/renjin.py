from . import BaseTarget, ExecResult

import command
import testr

class Target(BaseTarget):
	""" Renjin target. """

	def __init__(self):
		super().__init__()

	def defaultCmdArguments(self):
		return ()

	def defaultPath(self):
		return "/home/peta/devel/work/renjin/bin/renjin"
		#return "renjin"

	def initialize(self):
		super().initialize()
		try:
			self.command = command.Command(self.path)
			self.version = "Currently not supported";
			self.arch = "Currently not supported";
			testr.writeln("Target renjin initialized:")
		except IOError:
			testr.fatalError("Target path {0} not found!".format(self.path))

	def exec(self, test):	
			""" Runs the given test on the target and returns an ExecResult object. """
#		try:
			stdout,stderr,rc,time = self._exec(self.command,args = self.cmdArguments, input = test.code())
			if (time == "TIMEOUT"):
				return ExecResult(self,ExecResult.TIMEOUT,0,0,"","")
			# the execution was a success, clean the output
			stdout = self._extractOutput(stdout)
			new_stderr = ""
			for line in stderr.split("\n"):
				line = line.strip()
				if (not line):
					continue
				if (line.find("SLF4J") == 0):
					continue
				new_stderr += line + "\n"
			# return the exec result with no additional values
			return ExecResult(self, ExecResult.PASS, time, rc, stdout, new_stderr)
#		except:
			return ExecResult(self,ExecResult.FAIL, 0, 0, "", "")
