
from . import fastr


class Target(fastr.Target):

	def __init__(self):
		super().__init__()

	def defaultPath(self):
		return "fastr_graal"
