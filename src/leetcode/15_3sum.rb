require 'minitest/autorun'
# Given an integer array nums, return all the triplets [nums[i], nums[j], nums[k]]
# such that i != j, i != k, and j != k, and nums[i] + nums[j] + nums[k] == 0.

def three_sum(nums)
  nums.sort!
  len = nums.length
  results = []
  start = 0
  target = 0

  start.upto(len - 3).each do |i|
    next if i > start && nums[i - 1] == nums[i]

    j = i + 1
    k = len - 1

    while j < k
      sum = nums[i] + nums[j] + nums[k]

      if sum > target
        k -= 1
      elsif sum < target
        j += 1
      else
        results.push([nums[i], nums[j], nums[k]])
        j += 1
      end

      j += 1 while j > i + 1 && nums[j - 1] == nums[j]
      k -= 1 while k > len - 1 && nums[j + 1] == nums[k]
    end
  end

  results
end

describe '3 sum with target 0' do
  it 'returns the triplets adding upto zero' do
    expect(three_sum([-1, 0, 1, 2, -1, -4])).must_equal [[-1, -1, 2], [-1, 0, 1]]
  end

  it 'returns the triplets adding upto zero for zeros' do
    expect(three_sum([0, 0, 0, 0])).must_equal [[0, 0, 0]]
  end
end
