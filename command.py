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

	class Result:
		""" Possible results of the execution - SUCCESS and FAILURE known from C and the TIMEOUT marker for when the application execution timeouts. """

	def __init__(self, command):
		""" Creates the command instance for the given command. """
		self.command = command


	def run(self, args = (), input = None, timeout = 10):
		""" Executes the command with given arguments, possible input, and a timeout in seconds. Returns tuple consisting of standard output and error strings of the command, the return code from Command.Result enum and the duration of the execution. """

		def runner():
			cmd = self.command
			if (len(args) != 0):
				cmd = cmd + " " + " ".join(makeTupleIfNot(args))
			self.time = time.time()
			self.proc = subprocess.Popen(cmd, shell=not _isWindows, stdout = subprocess.PIPE, stderr = subprocess.PIPE, stdin = None if input == None else subprocess.PIPE)
			self.procOutput = self.proc.communicate(None if input == None else bytes(input,"UTF-8"))
			self.time = time.time() - self.time

		self.time = "TIMEOUT"
		thread = threading.Thread(target = runner)
		thread.start()
		thread.join(timeout)
		if (thread.is_alive()):
			self.proc.terminate()
			stdout = ""
			stderr = ""
			rc = Command.Result.TIMEOUT
		else:
			rc = self.proc.returncode
			stdout = self.procOutput[0].decode("UTF-8")
			stderr = self.procOutput[1].decode("UTF-8")
		return (stdout, stderr, rc, self.time)
