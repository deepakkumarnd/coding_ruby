# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../../src/leetcode/twosum'

class TwoSumTest < Minitest::Test
  def test_return_greeting
    assert_equal twosum([2, 7, 11, 15], 9), [0, 1]
    assert_equal twosum([3, 2, 4], 6), [1, 2]
    assert_equal twosum([3, 3], 6), [0, 1]
  end
end
