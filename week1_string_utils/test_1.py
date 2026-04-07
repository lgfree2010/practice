def sum(numbers):
    total = 0
    for n in numbers:
        total += n
    return total

def test_sum_equals_6():
    assert sum([1, 2, 3]) == 6
    print("Test passed!")

def test_sum_equals_0():
    assert sum([]) == 0
    print("Test passed!")