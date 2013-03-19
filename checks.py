from command import Command

# preRun commands

def checkTargetName(test, supportedTargets):
	""" Returns if the current target is supported by the test or not. """
	if (test.target.name not in supportedTargets):
		return "Not applicable for target %s, the test is only valid for: %s" % (test.target.name, ", ".join(supportedTargets))


# postRun commands

def assertOutput(output, expected, fromEnd = True):
	""" Checks that the output is the expected one. If partial is true, the check passes even if the actual output only contains the expected text. """
	if (fromEnd):
		if (output[-len(expected):] != expected):
			return "Expected string not found at the end of the output:\nOutput:   %s\nExpected: %s " % (output,expected)
	else:
		if (output != expected):
			return "Expected string not identical with formatted output:\nOutput:   %s\nExpected: %s " % (output,expected)


def assertOutputIsOnlyTrue(output, fromEnd = True):
	""" Checks that the output consists only of TRUE values and nothing else. Does not care how many true values it sees. """
	if (fromEnd):
		o = output.split(" ")
		i = len(o) - 1
		while (i>=0):
			if (o[i].strip() == "FALSE"):
				return "Expected only trailing TRUE values, but FALSE found:\n%s" % output
			if (o[i] != "TRUE"):
				break
			i -= 1
	else:
		if ("".join(output.split("TRUE")).strip()):
			return "Expected result of only TRUE values, but following result was found:\n%s" % output


def assertNoWarning(testErr):
	""" Returns true if the test did not produce any warning, which means the error ouput is empty. """
	if (testErr):
		return "Expected no warings, but stderr contains: %s" % testErr

def assertWarning(testErr, expected = False):
	""" Checks if there is a warning reported by the execution. If the epected argument is not specified, any warning will do, otherwise the expected contents of the warning is checked. """
	if (expected):
		if (testErr.find("Warning") == -1 or testErr.find(expected) == -1):
			return "Expected warning %s, but the following stderr found: %s" % (expected, testErr if (testErr) else "(empty)")
	else:
		if (testErr.find("Warning") == -1):
			return "Expected warning, but the following stderr found: %s" % (testErr if (testErr) else "(empty)")
		
def assertError(testErr, expected = False):
	""" Checks if there is an error reported by the execution. If the epected argument is not specified, any error will do, otherwise the expected contents of the warning is checked. """
	if (expected):
		if (testErr.find("Error") == -1 or testErr.find(expected) == -1):
			return "Expected error %s, but the following stderr found: %s" % (expected, testErr if (testErr) else "(empty)")
	else:
		if (testErr.find("Error") == -1):
			return "Expected error, but the following stderr found: %s" % (testErr if (testErr) else "(empty)")
		
