def remove_duplicates(nums)
  i = 0
  results = []
  while i < nums.length
    results.push(nums[i])
    i += 1
    i += 1 while nums[i - 1] == nums[i]
  end

  nums.replace(results)
  nums.length
end

nums = [1, 1, 2]

k = remove_duplicates(nums)

p k
p nums

nums = [0, 0, 1, 1, 1, 2, 2, 3, 3, 4]
k = remove_duplicates(nums)
p k
p nums
