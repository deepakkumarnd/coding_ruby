require 'minitest/autorun'
# Given a string s, find the length of the longest substring without duplicate characters.
#
# Time: O(n), the pos visits all the characters once.
# Space O(n), the hash allocates memory for all chars

def length_of_longest_substring(s)
  start = 0
  pos = start
  max_length = 0
  visited = {}

  # cache the length to avoid multiple length() method call
  length_of_string = s.length

  while pos < length_of_string
    # use s.getbyte(pos) for better performance, but getbytes won't work for multibyte characters such as emojis
    c = s[pos]
    last_visited_pos = visited[c]

    if last_visited_pos && (last_visited_pos >= start)
      max_length = [max_length, pos - start].max
      start = last_visited_pos + 1
    end

    visited[c] = pos
    pos += 1
  end

  [max_length, pos - start].max
end

class LongestSubstringTest < Minitest::Spec # rubocop:disable Style/Documentation
  describe 'Finds the length of the longest substring in the string' do
    it 'Evaluates to 3 for abc' do
      _(length_of_longest_substring('abc')).must_equal(3)
    end

    it 'Evaluates to 3 for abca' do
      _(length_of_longest_substring('abca')).must_equal(3)
    end

    it 'Evaluates to 4 for abcad' do
      _(length_of_longest_substring('abcad')).must_equal(4)
    end

    it 'Evaluates to 1 for a' do
      _(length_of_longest_substring('a')).must_equal(1)
    end

    it 'Evaluates to 1 for aa' do
      _(length_of_longest_substring('aa')).must_equal(1)
    end

    it 'Evaluates to 4 for abcdbe' do
      _(length_of_longest_substring('abcdbe')).must_equal(4)
    end

    it 'Evaluates to 3 for abcabcbb' do
      _(length_of_longest_substring('abcabcbb')).must_equal(3)
    end
  end
end
