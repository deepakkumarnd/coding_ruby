def remove_element(nums, val)
  i = 0

  while i < nums.length
    if nums[i] == val
      nums.delete_at(i)
    else
      i += 1
    end
  end

  nums.length
end

nums = [3, 2, 2, 3]
k = remove_element(nums, 3)
p k
p nums
