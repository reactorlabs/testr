# ---------------------------------------------------------------------------------------------------------------------
# GNU R testR classes
# ---------------------------------------------------------------------------------------------------------------------

from command import Command, _isWindows
from target import BaseTarget


class Target(BaseTarget):
	""" Target adapter for the fastr. Is capable of running the given tests on the VM in console mode. Provides input capture and vector decoder functions for easy tests. """

	DEFAULT_PATH = "./fastr"

	def __init__(self, path = False):
		""" Creates the fastr tester executor. Path arguments specifies the path of the gnu-r executable. Also determines the version and the architecture of the R it points to. """
		self.path = path if (path) else Target.DEFAULT_PATH
		self.command = Command(self.path)
		self.version = "Currently not supported";
		self.arch = "Currently not supported";

	def name(self):
		""" Determines the name of the target, that is the GNU R in this case. """
		return "fastr"

	def run(self, code):
		""" Runs the given code and returns the tuple consisting of stdout, stderr, return code and time the execution took in the same way the Command.run does. """
		stdout, stderr, rc, time = self.command.run(input = code)
		# get rid of messages that are not part of the canonical output
		if (stderr.find("at r.Console.main") != -1):
			return ("Java exception -- feature likely not supported","",0, BaseTarget.FEATURE_NOT_IMPLEMENTED)
		new_stderr = ""
		for line in stderr.split("\n"):
			line = line.strip()
			if (not line):
				continue
			if (line.find("Using BLAS") == 0):
				continue
			if (line.find("Using LAPACK") == 0):
				continue
			if (line.find("(stdin): Elapsed") == 0):
				continue
			new_stderr += line + "\n"
		return (stdout, new_stderr, rc, time)

	def extractOutput(self, runOut):
		""" Returns only those lines correspondling to the output of the run. Skips all lines to the first prompt and then only displays those lines that do not start with either > (prompt) or + (prompt continuation). If your target does not follow this convention you may need to reqrite this method. """
		result = ""
		# because the output from JDK shows input prompts but not the input itself, get rid of those, as well as of the commas between vector values
		for line in runOut[Command.STD_OUT].replace("> ", "").replace("+ ","").replace(", "," ").split("\n"):
			if (len(line) == 0):
				result += "\n"
			elif (line[0] not in ('>', '+')):
				if (line[-1] == '\r'):
						line = line[:-1]
				result += line + "\n"
		return result

	def vectorSkipWhitespaceDecoder(self, output):
		""" Given the output, it transforms it to a single vector of all values contained in it separated by space and no other whitespace characters anywhere between them. """
		result = ""
		lastWhitespace = False
		insideBrackets = False
		for c in output:
			if (c == '['):
				insideBrackets = True
				continue
			if (insideBrackets):
				if (c == ']'):
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

