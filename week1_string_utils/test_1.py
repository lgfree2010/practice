def my_sum(numbers):
    total = 0
    for n in numbers:
        total += n
    return total

def test_sum_equals_6():
    assert my_sum([1, 2, 3]) == 6

def test_sum_equals_0():
    assert my_sum([]) == 0
