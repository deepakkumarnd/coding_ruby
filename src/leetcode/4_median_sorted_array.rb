require 'minitest/autorun'
# Given two sorted arrays nums1 and nums2 of size m and n respectively, return the median of the two sorted arrays.

# The overall run time complexity should be O(log (m+n)).
#
# The following solution is a simple two pointer based solution not very efficient one

# Time: O(m+n), each element is visited once
# Space: O(m+n), a third array is created

def find_median_sorted_arrays(nums1, nums2)
  i = 0
  j = 0
  m = nums1.length
  n = nums2.length
  nums3 = []

  while i < m && j < n
    if nums1[i] <= nums2[j]
      nums3.push(nums1[i])
      i += 1
    else
      nums3.push(nums2[j])
      j += 1
    end
  end

  while i < m
    nums3.push(nums1[i])
    i += 1
  end

  while j < n
    nums3.push(nums2[j])
    j += 1
  end

  (m + n).even? ? (nums3[(m + n) / 2 - 1] + nums3[(m + n) / 2]) / 2.0 : nums3[(m + n) / 2.0]
end

describe 'Median of two sorted arrays' do
  it 'returns 3 as the median' do
    _(find_median_sorted_arrays([1, 2, 3], [4, 5])).must_equal(3)
  end

  it 'returns 3.5 as the median' do
    _(find_median_sorted_arrays([1, 2, 3], [4, 5, 6])).must_equal(3.5)
  end

  it 'returns 2 as the median' do
    _(find_median_sorted_arrays([1, 2, 3], [1, 2, 3])).must_equal(2)
  end

  it 'returns 2 as the median' do
    _(find_median_sorted_arrays([1, 2, 3], [1, 2])).must_equal(2)
  end
end
