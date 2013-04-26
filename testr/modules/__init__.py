import testr

class BaseModule:
	""" Basic module interface to be implemented by all modules. A module is a piece of code that is used to analyze every test on every target. """

	def __init__(self):
		testr.writeln("  creating module counter")
		self.outputFile = None

	def name(self):
		""" Returns the name of the module. The name of a testR module is the name of its python module. """
		return self.__class__.__module__.split(".")[-1]
	
	def doParseArgument(self, name, value):
		""" Analyzes the given argument specified by its name and value. This method should return True if the argument is recognized and the value is correct, and should return False if the argument is not recognized and should call the testr.fatalError function if the argument is recognized, but the value is not recognized.
	   
		Override this method while calling the inherited one to provide new functionality. 
	    """
		if (name in ("outputFile", "of")):
			if (self.outputFile != None):
				testr.fatalError("Output file for module {0} can only be specified once.".format(self.name()))
			try:
				self.outputFile = open(value,"w")
			except IOError:
				testr.fatalError("Unable to open output file {0} for write access.".format(value))
		else:
			return False
		return True

	def parseArguments(self, args):
		""" Parses arguments for the module. Module arguments must appear on the command line right after the module specification (--module=). Analyzes all arguments up to the first argument that is not understood by the current module (method doParseArgument() returns False).
	   
	   DO NOT OVERRIDE THIS METHOD, override the functionality provided in doParseArgument() and do not forget to call the old method.  """
		state = 0
		i = 0
		while (i < len(args)):
			arg = args[i]
			if (state == 0):
				i += 1
				if ((arg[0] in ("module","m")) and (arg[1] == self.name())):
					state = 1
				continue
			if (not self.doParseArgument(arg[0], arg[1])):
				break
			args.pop(i)

	def write(self,*args, force=False):
		testr.write(*args,force=force)
	
	def writeln(self,*args, force=False):
		testr.writeln(*args,force=force)


	def initialize(self, targets):
		pass

	def analyze(self, test, execResult):
		pass

	def finalize(self):
		pass