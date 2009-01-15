#!/usr/bin/python
# 
# Project Euler
#
# http://projecteuler.net/index.php?section=problems&id=12
#
# Problem 12
# 08 March 2002
#
# The sequence of triangle numbers is generated by adding the natural numbers.
# So the 7th triangle number would be 1 + 2 + 3 + 4 + 5 + 6 + 7 = 28. The first
# ten terms would be:
#
# 1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...
#
# Let us list the factors of the first seven triangle numbers:
#
#       1: 1
#       3: 1,3
#       6: 1,2,3,6
#      10: 1,2,5,10
#      15: 1,3,5,15
#      21: 1,3,7,21
#      28: 1,2,4,7,14,28
#
# We can see that the 7th triangle number, 28, is the first triangle number to
# have over five divisors.
#
# Which is the first triangle number to have over five-hundred divisors?
#
# Answer:
#
# FIXME: brute force


import sys


def number_of_primes(x):
        if x == 1:
                return 1
        n = 0
        divisor = 2
        sys.stdout.write("primes: ")
        while x != 1:
                while x % divisor == 0:
                # divisor is a prime
                        sys.stdout.write("%d " % (divisor))
                        x /= divisor
                        n += 1
                divisor += 1
        sys.stdout.write("| ")
        return n
# end of number_of_primes


def number_of_divisors1(x):
        if x == 1:
                return 1
        if x == 2:
                return 2
        n = 2 # 1 and x itself
        xx = x / 2 + 1
        y = 2
        while y < xx:
                if x % y == 0:
                        n += 1
                y += 1
        return n
# end of number_of_divisors


def number_of_combinations(n, k):
# return number of k-subsets in the set of n size
# http://en.wikipedia.org/wiki/Combinations
        c, d = 1, 1
        for i in range(n):
                c *= k-i
                d *= i+1
        return c / d
# end of number_of_combinations


def number_of_divisors2(x):
        if x == 1:
                return 1
        p = number_of_primes(x)
        n = 2 + p # 1, x itself, and all the primes
        for i in range(2, p):
                n += number_of_combinations(i, p)
        return n
# end of number_of_divisors2


print number_of_primes(139016053828)
sys.exit(1)

# main

i, x = 1, 1

number_of_divisors = number_of_divisors2

while 1:
        sys.stdout.write("%16d " % (x))
        sys.stdout.flush()
        nd = number_of_divisors(x)
        sys.stdout.write("%d " % (nd))
        
        if nd > 500:
                nd = number_of_divisors1(x)
                sys.stdout.write("%d " % nd)

        sys.stdout.write("\n")

        if nd > 500:
                break

        i += 1
        x += i

print x

# end of file
