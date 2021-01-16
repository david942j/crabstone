#!/usr/bin/env python2

import sys
import os
import importlib

def str_type(tp):
    if hasattr(tp, '_length_'):
        return '{}, {}'.format(tp._type_.__name__, tp._length_)
    else:
        return tp.__name__
def display(klass):
    # If any of the fields is not a native type, call display recursively.
    for var, tp in klass._fields_:
        if not tp.__name__.startswith('c_'):
            if hasattr(tp, '_length_'):
                # It's an array type
                display(tp._type_)
            else:
                display(tp)

    print('class {}:{}'.format(klass.__name__, klass.__class__.__name__))
    for var, tp in klass._fields_:
        print('  {}, {}'.format(var, str_type(tp)))
    print('')

def work(arch):
    mod = importlib.import_module('capstone.' + arch)
    main_struct = filter(lambda x: x.startswith('Cs'), dir(mod))[0]
    display(getattr(mod, main_struct))

if __name__ == '__main__':
    if len(sys.argv) != 2:
        print('Usage: {} x86'.format(sys.argv[0]))
        os.exit(1)
    work(sys.argv[1])
