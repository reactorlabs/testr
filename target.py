# ---------------------------------------------------------------------------------------------------------------------
# Base target
# ---------------------------------------------------------------------------------------------------------------------

from command import Command

class BaseTarget:
	""" Base target adapter. All target adapters must inherit from this adapter for them to work. This class lists the default functionality that should be provided by each such target. """

	FEATURE_NOT_IMPLEMENTED = "FEATURE_NOT_IMPLEMENTED"

#	def __init__(self, path = False):
#		""" Creates the tester executor. Path arguments specifies the path of the executable. If the path is false, the default path for the target should be used. The constructor also identifies the target filling in the path, arch and version.  """
#		self.path = path if (path) else DEFAULT_PATH
#		self.version = # version of the target 
#		self.arch = # architecture of the target

	def name(self):
		""" Determines the name of the target as specified by tests. """
		raise NotImplementedError("Override in children!"); 
		

	def run(self, code):
		""" Runs the given code and returns the tuple consisting of stdout, stderr, return code and time the execution took in the same way the Command.run does. """
		raise NotImplementedError("Override in children!"); 

	def extractOutput(self, runOut):
		""" Returns only those lines correspondling to the output of the run. Skips all lines to the first prompt and then only displays those lines that do not start with either > (prompt) or + (prompt continuation). If your target does not follow this convention you may need to reqrite this method. """
		header = True
		result = ""
		for line in runOut[Command.STD_OUT].split("\n"):
			if (header):
				if ((len(line) > 0) and (line[0] == '>')):
					header = False
			else:
				if (len(line) == 0):
					result += "\n"
				elif (line[0] not in ('>', '+')):
					if (line[-1] == '\r'):
						line = line[:-1]
					result += line + "\n"
		return result

	def vectorSkipWhitespaceDecoder(self, output):
		""" Given the output, it transforms it to a single vector of all values contained in it separated by space and no other whitespace characters anywhere between them. """
		raise NotImplementedError("Override in children!"); 


	def numberFormatter(self, output):
		""" Given the output, calls the vectorSkipWhitespace decoder and then looks at the output with all numbers being changed to a simple and unique representation. The "L" suffix is removed from integer numbers and any double number that is .0 is converted to an integer. """
		res = ""
		WHITESPACE = 0
		NUMBER = 1
		FRACTION = 2
		VALID_FRACTION = 3
		tokenStart = 0
		state = WHITESPACE
		i = 0
		for c in self.vectorSkipWhitespaceDecoder(output):
			if (state == WHITESPACE):
				if (c >= '0') and (c <= '9'):
					state = NUMBER
			elif (state == NUMBER):
				if (c == '.'):
					state = FRACTION
					tokenStart = i
				elif (c == 'L'): # skip the L after integer
					state = WHITESPACE
					continue 
				elif (c < '0') or (c > '9'):
					state = WHITESPACE
			elif (state == FRACTION):
				if (c > '0') and (c <= '9'):
					state = VALID_FRACTION
				elif (c != '0'):
					i = tokenStart
					res = res[:i]
					state = WHITESPACE
			elif (state == VALID_FRACTION):
				if (c < '0') or (c > '9'):
					state = WHITESPACE
			res = res + c
			i += 1
		if (state == FRACTION):
			res = res[:tokenStart]
		return res



