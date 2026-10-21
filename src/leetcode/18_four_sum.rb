require 'minitest/autorun'

# O(n^4)
def four_sum_v1(nums, target)
  len = nums.length
  results = {}

  (0..(len - 4)).each do |h|
    ((h + 1)..(len - 3)).each do |i|
      ((i + 1)..(len - 2)).each do |j|
        ((j + 1)..(len - 1)).each do |k|
          arr = [nums[h], nums[i], nums[j], nums[k]]

          if arr.sum == target
            key = arr.sort!.join
            results[key] = arr unless results.key?(key)
          end
        end
      end
    end
  end

  results.values.sort
end

def four_sum(nums, target)
  nums.sort!

  len = nums.length
  results = []

  0.upto(len - 4).each do |h|
    next if (h > 0) && nums[h - 1] == nums[h]

    (h + 1).upto(len - 3).each do |i|
      next if i > h + 1 && nums[i - 1] == nums[i]

      j = i + 1
      k = len - 1
      new_target = target - (nums[h] + nums[i])

      while j < k
        sum2 = nums[j] + nums[k]

        if sum2 > new_target
          k -= 1
        elsif sum2 < new_target
          j += 1
        else
          results.push([nums[h], nums[i], nums[j], nums[k]])
          j += 1
          # k -= 1
        end

        # k -= 1 while (k < len - 1) && nums[k] == nums[k + 1]
        j += 1 while (j > i + 1) && nums[j - 1] == nums[j]
      end
    end
  end

  results
end

def ksum(nums, target, k)
  nums.sort!
  len = nums.length
  results = []

  ksum_recur = lambda do |start, target, k, solution = []|
    if k > 2
      start.upto(len - k).each do |i|
        next if i > start && nums[i - 1] == nums[i]

        solution.push(nums[i])
        ksum_recur.call(i + 1, target - nums[i], k - 1, solution)
        solution.pop
      end
    else

      l = start
      r = len - 1

      while l < r
        sum = nums[l] + nums[r]

        if sum < target
          l += 1
        elsif sum > target
          r -= 1
        else
          results.push(solution + [nums[l], nums[r]])
          l += 1
        end

        l += 1 while l > start && nums[l - 1] == nums[l]
      end
    end
  end

  ksum_recur.call(0, target, k)

  results
end

describe 'four number sum' do
  it 'input [1, 0, -1, 0, -2, 2], target = 0' do
    expect(four_sum_v1([1, 0, -1, 0, -2, 2], 0)).must_equal [[-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]]
  end

  it 'input [1, 0, -1, 0, -2, 2], target = 0' do
    expect(four_sum_v1([1, 0, -1, 0, -2, 2], 0)).must_equal [[-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]]
  end

  it 'input [2,2,2,2,2], target = 8' do
    expect(four_sum_v1([2, 2, 2, 2, 2], 8)).must_equal [[2, 2, 2, 2]]
  end

  it 'input [1, 0, -1, 0, -2, 2], target = 0' do
    expect(four_sum([1, 0, -1, 0, -2, 2], 0)).must_equal [[-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]]
  end

  it 'input [1, 0, -1, 0, -2, 2], target = 0' do
    expect(ksum([1, 0, -1, 0, -2, 2], 0, 4)).must_equal [[-2, -1, 1, 2], [-2, 0, 0, 2], [-1, 0, 0, 1]]
  end

  it 'input [2,2,2,2,2], target = 8' do
    expect(four_sum([2, 2, 2, 2, 2], 8)).must_equal [[2, 2, 2, 2]]
  end

  it 'input [2,2,2,2,2], target = 8' do
    expect(ksum([2, 2, 2, 2, 2], 8, 4)).must_equal [[2, 2, 2, 2]]
  end

  it 'input [-3, -1, 0, 2, 4, 5], target = 0' do
    expect(four_sum([-3, -1, 0, 2, 4, 5], 0)).must_equal [[-3, -1, 0, 4]]
  end

  it 'input [-3, -1, 0, 2, 4, 5], target = 0' do
    expect(ksum([-3, -1, 0, 2, 4, 5], 0, 4)).must_equal [[-3, -1, 0, 4]]
  end

  it 'input [-2,-1,-1,1,1,2,2], target = 0' do
    expect(four_sum([-2, -1, -1, 1, 1, 2, 2], 0)).must_equal [[-2, -1, 1, 2], [-1, -1, 1, 1]]
  end

  it 'input [-2,-1,-1,1,1,2,2], target = 0' do
    expect(ksum([-2, -1, -1, 1, 1, 2, 2], 0, 4)).must_equal [[-2, -1, 1, 2], [-1, -1, 1, 1]]
  end
end
