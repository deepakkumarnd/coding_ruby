require 'minitest/autorun'

def three_sum_closest(nums, target)
  nums.sort!
  len = nums.length
  closest = nums[0, 3].sum

  0.upto(len - 3).each do |i|
    next if i > 0 && nums[i - 1] == nums[i]

    j = i + 1
    k = len - 1

    while j < k
      sum = nums[i] + nums[j] + nums[k]
      closest = sum if (target - sum).abs < (target - closest).abs

      if sum < target
        j += 1
        j += 1 while j > i + 1 && nums[j - 1] == nums[j]
      elsif sum > target
        k -= 1
        k -= 1 while k < len - 1 && nums[k + 1] == nums[k]
      else
        return closest
      end
    end
  end

  closest
end

describe 'Three sum closest' do
  it 'returns the closest sum to target' do
    expect(three_sum_closest([-1, 2, 1, -4], 1)).must_equal 2
  end

  it 'handles a large input with many duplicates' do
    # Possible sums: -21, -12, -9, -3, 0, 3, 6, 9, 12, 15; closest to 1 is 0
    nums = ([-7] * 400 + [2] * 400 + [5] * 400).shuffle(random: Random.new(42))
    expect(three_sum_closest(nums, 1)).must_equal 0
  end
end
