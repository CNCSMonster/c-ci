import lldb
from lldbsuite.test.decorators import *
from lldbsuite.test.lldbtest import *
from lldbsuite.test import lldbutil

class TestCase(TestBase):

    mydir = TestBase.compute_mydir(__file__)

    # GCC rejects the test code because `ToLayout` is not complete when
    # pointer_to_member_member is declared.
    @skipIf(compiler="gcc")
    # On Windows both MSVC and Clang are rejecting the test code because
    # `ToLayout` is not complete when pointer_to_member_member is declared.
    @skipIfWindows
    @no_debug_info_test
    def test(self):
        """
        This tests a pointer-to-member member which class part is the
        surrounding class. LLDB should *not* try to generate the record layout
        of the class when parsing pointer-to-member types while parsing debug
        info (as the references class might not be complete when the type is
        parsed).
        """
        self.build()
        self.dbg.CreateTarget(self.getBuildArtifact("a.out"))

        # Force the record layout for 'ToLayout' to be generated by printing
        # a value of it's type.
        self.expect("target variable test_var")
