require 'minitest/autorun'
require 'minitest/focus'
# Given a string s, return the longest palindromic substring in s.
#
# Time: O(n) in general but O(n^3) in worst case look at the last test
# Space: O(n)
# Here is a small optimizations but this won't do much time improvement,
# but increases space complexity to O(n), the possible_palindromes and verified_indices
# grows to the maximum in the first two iterations
def longest_palindrome(s)
  return s if s.length <= 1

  possible_palindromes = []
  verified_indices = { odd: {}, even: {} }

  (1..2).each do |len|
    (0...s.length).each do |mid|
      possible_palindromes.push([mid, len]) if palindrome?(s, mid, len, verified_indices)
    end
  end

  (3..s.length).step(2).each do |len|
    possibles = []
    (len..len + 1).each do |l|
      possible_palindromes.each do |mid, _current_len|
        possibles.push([mid, l]) if palindrome?(s, mid, l, verified_indices)
      end
    end

    break if possibles.empty?

    possible_palindromes = possibles
  end

  mid, max_length = possible_palindromes.last

  diff = max_length.odd? ? max_length / 2 : max_length / 2 - 1
  s.slice(mid - diff, max_length)
end

def palindrome?(s, mid, length, verified_indices)
  key = length.odd? ? :odd : :even
  # The substring till length - 2 is already a palindrome
  i, j = if verified_indices[key].key?(mid)
           a, b = verified_indices[key][mid]
           [a - 1, b + 1]
         else
           length.odd? ? [mid, mid] : [mid, mid + 1]
         end

  lower_bound, upper_bound = if length.odd?
                               [[0, mid - length / 2].max,
                                [mid + length / 2, s.length - 1].min]
                             else
                               [[0, mid - length / 2 + 1].max, [mid + length / 2, s.length - 1].min]
                             end

  while i >= lower_bound && j <= upper_bound
    return false if s.getbyte(i) != s.getbyte(j)

    i -= 1
    j += 1
  end

  verified_indices[key][mid] = [i + 1, j - 1]

  length == j - i - 1
end

describe 'Palindrome' do
  verified_indices = { odd: {}, even: {} }.freeze

  it 'Check if the string "malayalam" given is palindrome' do
    s = 'malayalam'
    _(palindrome?(s, s.length / 2, s.length, verified_indices.clone)).must_equal(true)
  end

  it 'Check resume from last known indices' do
    s = 'malayalam'
    _(palindrome?(s, s.length / 2, s.length, { odd: { 4 => [2, 6] } })).must_equal(true)
  end

  it 'Check if the string "a" is palindrome' do
    s = 'a'
    _(palindrome?(s, 0, s.length, verified_indices.clone)).must_equal(true)
  end

  it 'Check if the string "aa" is palindrome' do
    s = 'aa'
    _(palindrome?(s, 0, s.length, verified_indices.clone)).must_equal(true)
  end

  it 'Check if the string "aaa" is palindrome' do
    s = 'aba'
    _(palindrome?(s, 1, s.length, verified_indices.clone)).must_equal(true)
  end

  it 'Check if the string "abc" is palindrome given incorrect mid point' do
    s = 'aba'
    _(palindrome?(s, 0, s.length, verified_indices.clone)).must_equal(false)
  end

  it 'Check if the string "abc" is palindrome' do
    s = 'abc'
    _(palindrome?(s, 1, s.length, verified_indices.clone)).must_equal(false)
  end

  it 'Check if the string given is palindrome' do
    s = 'english'
    is_palindrome, _len = palindrome?(s, s.length / 2, s.length, verified_indices.clone)
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

  # focus
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

  # it 'Returnns longest test string' do
  #   s = 'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc'
  #   _(longest_palindrome(s)).must_equal(s)
  # end
end
