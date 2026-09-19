require 'minitest/autorun'
require 'minitest/focus'
# Given a string s, return the longest palindromic substring in s.
#
# Time: O(n) in general but O(n^3) in worst case look at the last test
# Space: O(n)
# Here is a small optimizations but this won't do much time improvement,
# but increases space complexity to O(n), the possible_palindromes and verified_cache
# grows to the maximum in the first two iterations
def longest_palindrome(s)
  return s if s.length <= 1

  possible_palindromes = []
  # For every position till L - 2 there is a possibility of even or odd lengthed palindrome
  # centered around the that position. For even we take the lower mid index as center
  # Space complexity (2*n) in worst case => O(n)
  verified_cache = { odd: {}, even: {} }

  # Create an initial list of possible palindromes with length 1 and 2
  # O(2 x n) => O(n)
  [1, 2].each do |len|
    (0...s.length).each do |mid|
      possible_palindromes.push([mid, len]) if palindrome?(s, mid, len, verified_cache)
    end
  end

  # possible_palindromes contains [center position, length]
  # all possible_palindromes will be grown from from one of the initial list item as the center
  # So we grow the possibles by advancing left and right centered on each of the possible_palindromes
  # Since we grow in both direction we advance current length by 2
  # O(n * possible_palindroms.length == O(n)) => O(n^2) worst case
  (3..s.length).each do
    possibles = []
    possible_palindromes.each do |mid, current_len|
      possibles.push([mid, current_len + 2]) if palindrome?(s, mid, current_len + 2, verified_cache)
    end

    break if possibles.empty?

    # Space complexity 2n-1 => 1 ie: O(n)
    possible_palindromes = possibles
  end

  mid, max_length = possible_palindromes.last

  diff = max_length.odd? ? max_length / 2 : max_length / 2 - 1
  s.slice(mid - diff, max_length)
end

def get_bounds(full_length, mid, length)
  if length.odd?
    [[0, mid - length / 2].max,
     [mid + length / 2, full_length - 1].min]
  else
    [[0, mid - length / 2 + 1].max,
     [mid + length / 2, full_length - 1].min]
  end
end

# Check if the slice of length centered around mid is a palindrome
# the verified_cache contains the indices for a midpoint around which the
# slice is already a palindrome, if the same mid comes with a higher length we
# can skip verifying already verified indices and expand from the last verified
# indices
# O(n)
def palindrome?(s, mid, length, verified_cache)
  key = length.odd? ? :odd : :even
  # The substring till length - 2 is already a palindrome
  left, right =
    if verified_cache[key].key?(mid)
      left_verified, right_verified = verified_cache[key][mid]
      [left_verified - 1, right_verified + 1]
    else
      length.odd? ? [mid, mid] : [mid, mid + 1]
    end

  lower_bound, upper_bound = get_bounds(s.length, mid, length)

  while left >= lower_bound && right <= upper_bound
    return false if s.getbyte(left) != s.getbyte(right)

    verified_cache[key][mid] = [left, right]

    left -= 1
    right += 1
  end

  length == right - left - 1
end

# Testing
verified_cache = nil

describe 'Palindrome' do # rubocop:disable Metrics/BlockLength
  before(:each) do
    verified_cache = { odd: {}, even: {} }
  end

  it 'Check if the string "malayalam" given is palindrome' do
    s = 'malayalam'
    _(palindrome?(s, s.length / 2, s.length, verified_cache)).must_equal(true)
  end

  it 'Check resume from last known indices' do
    s = 'malayalam'
    _(palindrome?(s, s.length / 2, s.length, { odd: { 4 => [2, 6] } })).must_equal(true)
  end

  it 'Check if the string "a" is palindrome' do
    s = 'a'
    _(palindrome?(s, 0, s.length, verified_cache)).must_equal(true)
  end

  it 'Check if the string "aa" is palindrome' do
    s = 'aa'
    _(palindrome?(s, 0, s.length, verified_cache)).must_equal(true)
  end

  it 'Check if the string "aaa" is palindrome' do
    s = 'aba'
    _(palindrome?(s, 1, s.length, verified_cache)).must_equal(true)
  end

  it 'Check if the string "aba" is palindrome given incorrect mid point' do
    s = 'aba'
    _(palindrome?(s, 0, s.length, verified_cache)).must_equal(false)
  end

  it 'Check if the string "abc" is palindrome' do
    s = 'abc'
    _(palindrome?(s, 1, s.length, verified_cache)).must_equal(false)
  end

  it 'Check if the string given is palindrome' do
    s = 'english'
    is_palindrome, _len = palindrome?(s, s.length / 2, s.length, verified_cache)
    _(is_palindrome).must_equal(false)
  end

  it 'Return longest palindrome' do
    s = 'malayalam'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'Return longest palindrome substring for "ilovemalayalam"' do
    s = 'ilovemalayalam'
    _(longest_palindrome(s)).must_equal('malayalam')
  end

  it 'Return longest palindrome substring' do
    s = 'abccba'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'Return longest palindrome substring "a"' do
    s = 'a'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'Return longest palindrome substring "aa"' do
    s = 'aa'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'Return longest palindrome substring "aaa"' do
    s = 'aaa'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'Return longest palindrome substring "aaaa"' do
    s = 'aaaa'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'Return longest palindrome substring "aaaaa"' do
    s = 'aaaaa'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'A complex test string' do
    s = 'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'Returns longest test string for "ccccc"' do
    s = 'ccccc'
    _(longest_palindrome(s)).must_equal(s)
  end

  it 'Returns longest test string for "abcac"' do
    s = 'abcac'
    _(longest_palindrome(s)).must_equal('cac')
  end
end
