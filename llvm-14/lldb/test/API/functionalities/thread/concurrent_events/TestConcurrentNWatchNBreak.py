
import unittest2

from lldbsuite.test.decorators import *
from lldbsuite.test.concurrent_base import ConcurrentEventsBase
from lldbsuite.test.lldbtest import TestBase


@skipIfWindows
class ConcurrentNWatchNBreak(ConcurrentEventsBase):

    mydir = ConcurrentEventsBase.compute_mydir(__file__)

    # Atomic sequences are not supported yet for MIPS in LLDB.
    @skipIf(triple='^mips')
    @expectedFailureAll(archs=["aarch64"], oslist=["freebsd"],
                        bugnumber="llvm.org/pr49433")
    @skipIf(
        oslist=["ios", "watchos", "tvos", "bridgeos", "macosx"],
        archs=['arm64', 'arm64e', 'arm64_32', 'arm'],
        bugnumber="rdar://81811539")
    @add_test_categories(["watchpoint"])
    def test(self):
        """Test with 5 watchpoint and breakpoint threads."""
        self.build()
        self.do_thread_actions(num_watchpoint_threads=5,
                               num_breakpoint_threads=5)
