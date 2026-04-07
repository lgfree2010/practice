from test_string_utils import is_prime

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
