

import test_f;
import test_ff;
import test_hf;
import test_pf;

if __name__ == '__main__':
    tests=[test_f.test,test_ff.test,test_hf.test,test_pf.test]
    for test in tests :
        if not test():
            break
        
if __name__ == '__main__':
    test()