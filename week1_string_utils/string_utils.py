def is_prime(n):
    if n < 2:
        return False
    for i in range(2, n):
        if n % i == 0:
            return False
    return True

def reverse_string(s):
    return s[::-1]

def my_sum(numbers):
    total = 0
    for n in numbers:
        total += n
    return total

def max_of_three(a, b, c):
    return max(a, b, c)