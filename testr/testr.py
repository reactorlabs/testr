
import sys
import testsuite
import importlib
import threading
import targets
from targets import ExecResult
import modules
import time

verbose = True # MAKE SURE TO SET THIS TO NONE!!!!!!
n = None

def writeln(*args, force = False):
	if (verbose or force):
		print(*args)

def write(*args, force = False):
	if (verbose or force):
		print(*args,end="")

def truncIfLonger(str,length = 80):
	if (len(str) > length):
		return "..."+str[-77:]
	else:
		return str + " " * (length - len(str))

def fatalError(message):
	print(message)
	print("Exitting testR. Use testR --help for information about how to run testR framework. ")
	sys.exit()

def readArgument(arg):
	""" Parses the given argument to a name/value tuplet. The argument must be in form of {-}NAME[=VALUE]. If the =VALUE is not present, the value of the argument is True. If the value is "false", the false boolean value will be returned."""
	while (arg[0] == "-"): # get rid of the initial hyphens, if any
		arg = arg[1:]
	s = arg.split("=")
	if (len(s) == 1):
		writeln("  parsed argument {0} with value {1}".format(s[0],"True"))
		return (s[0], True)
	elif (s[1].lower() == "false"):
		writeln("  parsed argument {0} with value {1}".format(s[0],"False"))
		return (s[0], False)
	else:
		writeln("  parsed argument {0} with value {1}".format(s[0],s[1]))
		return (s[0], s[1])

def readArgumentFile(filename, args):
	""" Parses the arguments in given file and adds them to the list of arguments. The updated list of arguments is returned. The argument includes can be nested. """
	writeln("  reading arguments from file ",filename)
	f = open(filename,"r")
	for line in f:
		lien = line.strip()
		if (not line):
			continue
		if (line[0] == "#"):
			continue
		name, value = readArgument(line.strip())
		if (name in ("include", "i")):
			readArgumentFile(filename, args)
		else:
			args.append((name, value))
	f.close()
	return args

def readArguments():
	""" Parses the arguments given to the testR either on the command line, or in a file to the name/value tuples. Normally, command line arguments are used as a source, however the -include=filename argument can specify that the contents of the given file will be inserted to the arguments stream. These includes can be hierarchical. The included files must specify the command line arguments on a command per line basis."""
	args=[]
	writeln("parsing arguments...")
	if (len(sys.argv)==1):
		writeln("  no arguments found, including arguments.txt")
		readArgumentFile("arguments.txt",args)
	else:
		for arg in sys.argv[1:]:
			name, value = readArgument(arg)
			if (name in ("include", "i")):
				readArgumentFile(value, args)
			else:
				args.append((name, value))
	return args

def parseArguments(args):
	""" Parses the given arguments. Returns the list of modules and targets to be created and used during the execution. """
	global verbose
	global n
	i = 0
	modules = []
	targets = []
	writeln("parsing command line arguments...")
	while (i < len(args)):
		name, value = args[i]
		if (name in ("help","h","?","/help","/h","/?")):
			help()
		elif (name in ("module", "m")):
			try:
				m = importlib.import_module("modules.{0}".format(value))
				m = m.Module()
				m.parseArguments(args)
				modules.append(m)
			except ImportError:
				fatalError("Module {0} cannot be found. Please make sure the module is in folder modules and has the same name (excluding the .py suffix) as the module you are trying to use.".format(value))
		elif (name in ("target", "t")):
			try:
				t = importlib.import_module("targets.{0}".format(value))
				t = t.Target()
				t.parseArguments(args)
				targets.append(t)
			except ImportError:
				fatalError("Target {0} cannot be found. Please make sure the target is in folder targets and has the same name (excluding the .py suffix) as the target you are trying to use.".format(value))
		elif (name in ("verbose", "v")):
			if (verbose != None):
				fatalError("Verbosity can only be set once")
			verbose = True if value else False
			writeln("  verbosity set to {0}".format(verbose))
		elif (name in ("nthreads", "n")):
			if (n != None):
				fatalError("Number of threads can only be set once. ")
			n = int(value)
			writeln("  number of threads set to {0}".format(n))
		else:
			i += 1
			continue
		args.pop(i)
	if (verbose == None):
		verbose = False
	if (n == None):
		n = 1
	return (modules, targets)

def testerThread(modules,targets,testsuite,i):
	""" """
	writeln("thread started...")
	if (targets):
		for test in testsuite:
			for m in modules:
				for t in targets:
					while (True):
						tr = t.exec(test)
						r = m.analyze(test, tr)
						if (r != ExecResult.RETRY):
							break
	else:
		for test in testsuite:
			for m in modules:
				m.analyze(test, None)
	writeln("thread finished...")
	pass  


def testr():
	""" Main method for the testR framework. Analyzes the arguments given """
	global n
	time_startup = time.time()
	writeln("testR v 2")
	# first read the arguments and get them into the list
	args = readArguments()
	# parse the arguments
	modules, targets = parseArguments(args)
	# initialize the targets
	for t in targets:
		t.initialize()
	# initialize the modules
	for m in modules:
		m.initialize(targets)
	# initialize the test suite
	ts = testsuite.TestSuite(args)
	# now spawn the threads and make them work on the TestSuite
	time_start = time.time()
	threads = []
	for i in range(n):
		threads.append(threading.Thread(target=testerThread,args=(modules,targets,ts,i)))
	for t in threads:
		t.start()
	for t in threads:
		t.join()
	# finalize the modules
	time_finalize = time.time() 
	for m in modules:
		m.finalize()
	time_end = time.time()
	writeln("\n----- testr timing status -----\n", force = True)
	writeln("  total:    {0}".format(time_end - time_startup), force = True)
	writeln("  startup:  {0}".format(time_start - time_startup), force = True)
	writeln("  analysis: {0}".format(time_finalize - time_start), force = True)
	writeln("  teardown: {0}".format(time_end - time_finalize), force = True)


def help():
	print("""
testR v 2
---------

Test definition & execution framework for the R language. Main principles of
testR are test suites, modules and targets:

Test Suite
----------

Test suite is a collection of tests. Tests can be organized 

python3 testr.py ARGS testSuite

where ARGS is any of the following and the testSuite is the path to the root
directory of the test suite where all the tests are stored. Each test file
will be analyzed, the tests produced and appropriate backends will be called
for their evaluation. 

	""")
	sys.exit()

if (__name__=="__main__"):
	try:
		if (sys.version_info.major != 3):
			testr.fatalError("Python3 is required for testr to work!")
	except:
		testr.fatalError("Python3 is required for testr to work!")
	testr()
