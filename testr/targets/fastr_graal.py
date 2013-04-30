
from . import fastr

import testr

class Target(fastr.Target):

	def __init__(self):
		super().__init__()
		self._printTruffleInfo = True

	def defaultPath(self):
		return "fastr_graal"

	def doParseArgument(self, name, value):
		if (super().doParseArgument(name, value)):
			return True
		if (name in ("printTruffleInfo","pti")):
			self._printTruffleInfo = True if value else False
		else:
			return False
		return True


	def _extractOutput(self, runOut):
		""" Returns only those lines correspondling to the output of the run. Skips all lines to the first prompt and then only displays those lines that do not start with either > (prompt) or + (prompt continuation). If your target does not follow this convention you may need to reqrite this method. """
		runOut = super()._extractOutput(runOut);
		output = ""
		for line in runOut.split("\n"):
			l = line.strip()
			if (l.find("[truffle]") != 0):
				if (l):
					output += line+"\n"
			else:
				if (self._printTruffleInfo):
					testr.writeln(l)
		return output
