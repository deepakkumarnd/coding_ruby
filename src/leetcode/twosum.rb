# frozen_string_literal: true

#
# Given an array of integers nums and an integer target, return indices of the
# two numbers such that they add up to target. You may assume that each input
# would have exactly one solution, and you may not use the same element twice.
# You can return the answer in any order.

def twosum(arr, target)
  (0..arr.length).each do |i|
    balance = target - arr[i]

    ((i + 1)..arr.length).each do |j|
      return [i, j] if arr[j] == balance
    end
  end
end
