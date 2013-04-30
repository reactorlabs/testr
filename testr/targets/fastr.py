from . import BaseTarget, ExecResult

import command
import testr

class Target(BaseTarget):
	""" FASTR target, a path to the fastr repository must be submitted. """

	def __init__(self):
		super().__init__()

	def defaultCmdArguments(self):
		return ()

	def defaultPath(self):
		return "fastr"

	def initialize(self):
		super().initialize()
		try:
			self.command = command.Command(self.path)
			self.version = "Currently not supported";
			self.arch = "Currently not supported";
			#v = self.command.run(args= self.cmdArguments)
			#v = v[1].split("\n") if command._isWindows else v[0].split("\n")
			#self.LAPACK = v[0].split(" ")[2].strip()
			#self.BLAS = v[1].split(" ")[2].strip()
			#self.GNUR = v[2].split(" ")[2].strip()
			testr.writeln("Target fastr initialized:")
			testr.writeln("  arch:    {0}".format(self.arch))
			testr.writeln("  version: {0}".format(self.version))
			testr.writeln("  path:    {0}".format(self.path))  
			#testr.writeln("  LAPACK: {0}".format(self.LAPACK))
			#testr.writeln("  BLAS:   {0}".format(self.BLAS))
			#testr.writeln("  GNUR:   {0}".format(self.GNUR))  
		except IOError:
			testr.fatalError("Target path {0} not found!".format(self.path))

	def exec(self, test):	
			""" Runs the given test on the target and returns an ExecResult object. """
#		try:
			stdout,stderr,rc,time = self.command.run(args = self.cmdArguments, input = test.code())
			if (time == "TIMEOUT"):
				return ExecResult(self,ExecResult.TIMEOUT,0,0,"","")
			# the execution was a success, clean the output
			stdout = self._extractOutput(stdout)
			new_stderr = ""
			time = None
			for line in stderr.split("\n"):
				line = line.strip()
				if (not line):
					continue
				if (line.find("Using BLAS") == 0):
					continue
				if (line.find("Using LAPACK") == 0):
					continue
				if (line.find("Using GNUR") == 0):
					continue
				if (line.find("(stdin): Elapsed") == 0):
					#(stdin): Elapsed 1313 microseconds
					time = float(line.split(" ")[2]) / 1000000
					continue
				new_stderr += line + "\n"
			# return the exec result with no additional values
			if (time == None):
				return ExecResult(self, ExecResult.PASS, time, rc, stdout, new_stderr)
			else:
				return ExecResult(self, ExecResult.PASS, time, rc, stdout, new_stderr, vmTime = time)

#		except:
			return ExecResult(self,ExecResult.FAIL, 0, 0, "", "")


	def _extractOutput(self, runOut):
		""" Returns only those lines correspondling to the output of the run. Skips all lines to the first prompt and then only displays those lines that do not start with either > (prompt) or + (prompt continuation). If your target does not follow this convention you may need to reqrite this method. """
		result = ""
		# because the output from JDK shows input prompts but not the input itself, get rid of those, as well as of the commas between vector values
		for line in runOut.replace("> ", "").replace("+ ","").replace(", "," ").split("\n"):
			if (len(line) == 0):
				result += "\n"
			elif (line[0] not in ('>', '+')):
				if (line[-1] == '\r'):
						line = line[:-1]
				result += line + "\n"
		return result
