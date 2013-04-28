
from . import gnur32


class Target(gnur32.Target):

	def __init__(self):
		super().__init__()

	def _arguments(self):
		return ("--vanilla",)
