require 'minitest/autorun'

# Given an array of integers nums and an integer target, return indices of the
# two numbers such that they add up to target. You may assume that each input
# would have exactly one solution, and you may not use the same element twice.
# You can return the answer in any order.
#
# Time:  O(n) - each number is visited at most once
# Space: O(n) - the seen hash can grow to hold up to n-1 numbers
def two_sum(numbers, target)
  seen = {}

  numbers.each_with_index do |number, index|
    compliment = target - number

    return [seen[compliment], index] if seen.key?(compliment)

    seen[number] ||= index
  end

  []
end

# Tests for the two sum problem
class TwoSumTest < Minitest::Test
  def test_two_sum
    assert_equal two_sum([2, 7, 11, 15], 9), [0, 1]
    assert_equal two_sum([3, 2, 4], 6), [1, 2]
    assert_equal two_sum([3, 3], 6), [0, 1]
  end
end
