from string_utils import max_of_three

def test_max_of_basic():
    assert max_of_three(1, 2, 3) == 3

def test_max_of_equal_numbers():
    assert max_of_three(5, 5, 5) == 5

def test_max_of_negative_numbers():
    assert max_of_three(-1, -2, -3) == -1

def test_max_of_mixed_numbers():
    assert max_of_three(-1, 2, -3) == 2

def test_max_of_largest():
    assert max_of_three(100, 2002, 1) == 2002

def test_max_of_first_largest():
    assert max_of_three(2002, 100, 1) == 2002

def test_max_of_last_largest():
    assert max_of_three(1, 100, 2002) == 2002

def test_max_of_second_largest():
    assert max_of_three(1, 2002, 100) == 2002

def test_max_of_zero():
    assert max_of_three(0, 0, 0) == 0

