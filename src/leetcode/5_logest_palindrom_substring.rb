require 'minitest/autorun'
# Given a string s, return the longest palindromic substring in s.
#
# Time: O(n^3) worst case
# Space: O(1)
# Here is a small optimizations but this won't do much time improvement,
# but increases space complexity to O(n)
def longest_palindrome(s)
  length = s.length
  sub_string_max_length = {}

  while length.positive?
    start = 0
    while start + length <= s.length
      return length if sub_string_max_length.key?(length)

      yes, len = palindrome?(s, start, length)
      return length if yes

      sub_string_max_length[len] = true

      start += 1
    end

    length -= 1
  end

  false
end

def palindrome?(s, start, length)
  end_position = start + length - 1
  mid = (start + end_position) / 2

  i, j = length.odd? ? [mid, mid] : [mid - 1, mid]
  len = 0

  while i >= start && j <= end_position
    return [false, len] if s.getbyte(i) != s.getbyte(j)

    len += (i == j ? 1 : 2)
    i -= 1
    j += 1
  end

  [true, len]
end

describe 'Longest palindrome' do
  it 'Check if the string given is palindrome' do
    s = 'malayalam'
    _(palindrome?(s, 0, s.length)).must_equal([true, 9])
  end

  it 'Check if the string given is palindrome' do
    s = 'english'
    is_palindrome, _len = palindrome?(s, 0, s.length)
    _(is_palindrome).must_equal(false)
  end

  it 'Return longest palindrome length' do
    s = 'malayalam'
    _(longest_palindrome(s)).must_equal(s.length)
  end

  it 'Return longest palindrome substring length' do
    s = 'ilovemalayalam'
    _(longest_palindrome(s)).must_equal('malayalam'.length)
  end

  it 'Return longest palindrome substring length' do
    s = 'ilovemalayalam'
    _(longest_palindrome(s)).must_equal('malayalam'.length)
  end
end
