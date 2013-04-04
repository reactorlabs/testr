# ---------------------------------------------------------------------------------------------------------------------
# GNU R testR classes
# ---------------------------------------------------------------------------------------------------------------------

from command import Command, _isWindows
from target import BaseTarget


class Target(BaseTarget):
	""" Target adapter for the gnu-r. Is capable of running the given tests on the VM in console mode. Provides input capture and vector decoder functions for easy tests. Any new target should provide at least the methods specified in the gnu-r target. """


	DEFAULT_PATH = "c:/Program Files/R/R-2.15.2/bin/R.exe"

	def __init__(self, path = False):
		""" Creates the gnu-r tester executor. Path arguments specifies the path of the gnu-r executable. Also determines the version and the architecture of the R it points to. """
		self.path = path if (path) else Target.DEFAULT_PATH
		self.command = Command(self.path+" --arch 32")
		v = self.command.run("--version")
		v = v[1].split("\n") if _isWindows else v[0].split("\n")
		self.version = v[0].strip().split(" ")[2]
		self.arch = v[3].strip().split(" ")[1]

	def name(self):
		""" Determines the name of the target, that is the GNU R in this case. """
		return "gnur32"

	def run(self, code):
		""" Runs the given code and returns the tuple consisting of stdout, stderr, return code and time the execution took in the same way the Command.run does. """
		return self.command.run(args = "--vanilla", input = code)

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



