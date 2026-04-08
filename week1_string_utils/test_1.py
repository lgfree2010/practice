from string_utils import my_sum

def test_sum_equals_6():
    assert my_sum([1, 2, 3]) == 6

def test_sum_equals_0():
    assert my_sum([]) == 0

def test_sum_negative():
    assert my_sum([-1, -2, -3]) == -6

def test_sum_float():
    assert my_sum([1.6,2.4,3.0]) == 7.0

def test_sum_mixed():
    assert my_sum([1, -2, 3]) == 2

def test_sum_large():
    assert my_sum([1000000, 2000000, 3000000]) == 6000000

def test_sum_single_element():
    assert my_sum([5]) == 5