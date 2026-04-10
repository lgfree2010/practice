from string_utils import reverse_string
import pytest

@pytest.mark.parametrize("input, expected", [("hello", "olleh"), ("", ""), ("a", "a"), (" ", " "), ("hello world", "dlrow olleh"),("你好世界","界世好你"),
                                             ("!@#$%^&*()",")(*&^%$#@!"),("racecar","racecar"),("aba","aba")])
def test_reverse_string(input, expected):
    assert reverse_string(input) == expected

'''
def test_reverse_string():
    assert reverse_string("hello") == "olleh"

def test_reverse_empty_string():
    assert reverse_string("") == ""

def test_reverse_single_character():
    assert reverse_string("a") == "a"

def test_reverse_space():
    assert reverse_string(" ") == " "

def test_reverse_multiple_characters():
    assert reverse_string("hello world") == "dlrow olleh"

def test_reverse_Chinese():
    assert reverse_string("你好世界") == "界世好你"

def test_reverse_special_characters():
    assert reverse_string("!@#$%^&*()") == ")(*&^%$#@!"

def test_reverse_palindrome():
    assert reverse_string("racecar") == "racecar"
    assert reverse_string("aba") == "aba"

def test_reverse_numbers():
    assert reverse_string("12345") == "54321"

def test_reverse_mixed_Chinese_English():
    assert reverse_string("Hello 你好") == "好你 olleH"
'''

