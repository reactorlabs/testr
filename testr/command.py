import subprocess
import threading
import time

import os

_isWindows = (os.name == "nt")


def makeTupleIfNot(what):
	""" If the given argument is a tuple or a list, returns it without any modifications. Otherwise creates a tuple with the single element. """ 
	if (type(what) == tuple or type(what) == list):
		return what
	else:
		return (what,)

# ---------------------------------------------------------------------------------------------------------------------
# Command
# ---------------------------------------------------------------------------------------------------------------------

class Command:
	""" Class used to run external programs. When initialized, the command name is provided. The command can then be launched multiple times. An input can be specified, in which case this is sent to the external application to its stdin. For each execution, different arguments can also be specified. """

	STD_OUT = 0
	STD_ERR = 1
	RETURN_CODE = 2
	EXEC_TIME = 3
	SUCCESS = 0
	FAILURE = 1
	TIMEOUT = "TIMEOUT"

	class ExecRecord:

		def __init__(self):
			self.time = Command.TIMEOUT
			self.proc = None
			self.procOutput = ""

	def __init__(self, command):
		""" Creates the command instance for the given command. """
		self.command = command


	def run(self, args = (), input = None, timeout = 600):
		""" Executes the command with given arguments, possible input, and a timeout in seconds. Returns tuple consisting of standard output and error strings of the command, the return code from Command.Result enum and the duration of the execution. """

		def runner(rec):
			cmd = self.command
			if (len(args) != 0):
				cmd = cmd + " " + " ".join(makeTupleIfNot(args))
			rec.time = time.time()
			rec.proc = subprocess.Popen(cmd, shell=not _isWindows, stdout = subprocess.PIPE, stderr = subprocess.PIPE, stdin = None if input == None else subprocess.PIPE)
			rec.procOutput = rec.proc.communicate(None if input == None else bytes(input,"UTF-8"))
			rec.time = time.time() - rec.time

		rec = Command.ExecRecord()
		thread = threading.Thread(target = runner, args = (rec,))
		thread.start()
		thread.join(timeout)
		if (thread.is_alive()):
			rec.proc.terminate()
			return ("","",Command.TIMEOUT, Command.TIMEOUT)
		else:
			rc = rec.proc.returncode
			try:
			    stdout = rec.procOutput[0].decode("UTF-8")
			except:
				stdout = "NOT AN UTF-8 DECODABLE OUTPUT"
			try:
				stderr = rec.procOutput[1].decode("UTF-8")
			except:
				stderr = "NOT AN UTF_8 DECODABLE ERROR"
			return (stdout, stderr, rc, rec.time)
