from string_utils import is_prime
import pytest

@pytest.mark.parametrize("invalid_input", [None, "not_a_number", 3.14])
def test_is_prime_invalid_input(invalid_input):
    with pytest.raises(TypeError):
        is_prime(invalid_input)

@pytest.fixture
def prime_sample():
    return {"n": 11, "expected": True}

@pytest.mark.parametrize("n, expected", [(2, True), (3, True), (4, False), (1, False), (0, False), (-5, False),(997,True),(100010,False)])
def test_is_prime(n, expected):
    assert is_prime(n) == expected

def test_is_prime_sample(prime_sample):
    assert is_prime(prime_sample["n"]) == prime_sample["expected"]

'''
def test_is_prime_2():
    assert is_prime(2) == True

def test_is_prime_3():
    assert is_prime(3) == True

def test_is_prime_4():
    assert is_prime(4) == False
def test_is_not_prime_1():
    assert is_prime(1) == False
def test_is_not_prime_0(): 
    assert is_prime(0) == False
def test_is_prime_negative():
    assert is_prime(-5) == False
def test_is_prime_large():
    assert is_prime(997) == True
    assert is_prime(10091000) == False
'''
