def next_permutation(nums)
  len = nums.length

  arr = []
  i = len - 1
  last_number = true

  while i.positive?
    arr.push(nums[i])
    if nums[i - 1] >= nums[i]
      i -= 1
    else
      last_number = false
      arr.sort!
      arr.each_with_index do |el, j|
        next unless el > nums[i - 1]

        tmp = nums[i - 1]
        nums[i - 1] = el
        arr[j] = tmp
        break
      end

      j = 0

      while i + j < len
        nums[i + j] = arr[j]
        j += 1
      end

      break
    end
  end

  last_number ? nums.reverse! : nums
end

p next_permutation([1, 2, 3, 4, 5])
p next_permutation([1, 2, 3, 5, 4])
p next_permutation([1, 2, 4, 3, 5])
p next_permutation([1, 2, 4, 5, 3])
p next_permutation([1, 2, 5, 3, 4])
p next_permutation([1, 2, 5, 4, 3])
p next_permutation([1, 3, 2, 4, 5])
p next_permutation([1, 3, 2, 4, 5])
p next_permutation([4, 5, 3, 2, 1])

p next_permutation([3, 2, 1])
p next_permutation([5, 1, 1])
