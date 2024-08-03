#!/usr/bin/env python

import importlib.util
import os
import sys

def str_type(tp):
    if hasattr(tp, '_length_'):
        return '{}, {}'.format(tp._type_.__name__, tp._length_)
    else:
        return tp.__name__

def load_capstone_binding(path):
    spec = importlib.util.spec_from_file_location('capstone', f'{path}/__init__.py')
    mod = importlib.util.module_from_spec(spec)
    sys.modules['capstone'] = mod
    spec.loader.exec_module(mod)

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
    mod = getattr(sys.modules['capstone'], arch)
    main_struct = next(filter(lambda x: x.startswith('Cs'), dir(mod)))
    display(getattr(mod, main_struct))

if __name__ == '__main__':
    if len(sys.argv) != 3:
        print('Usage: {} <path/to/capstone/bindings/python/capstone> x86'.format(sys.argv[0]))
        os.exit(1)
    load_capstone_binding(sys.argv[1])
    work(sys.argv[2])
