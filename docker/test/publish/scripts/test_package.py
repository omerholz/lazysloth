from lazysloth import LazyVariable

var = LazyVariable(int, '4')

assert var == 4

var = LazyVariable(list, ['a','b','c'])

assert len(var) == 3
assert 'b' in var
assert var[0] == 'a'
assert var[-1] == 'c'

