# Longest Palindrome simple version Time - O(n^3)
#
# For every length L from largest to smallest check all substrings
# to know if it is a palindrome or not. If yes return the substring.
module LongestPalindromeV2
  extend self

  def palindrome?(s, start_pos, end_pos)
    return false if start_pos > end_pos

    while start_pos <= end_pos
      return false if s[start_pos] != s[end_pos]

      start_pos += 1
      end_pos -= 1
    end

    true
  end

  def longest_palindrome(s)
    return s if s.empty? || s.length == 1

    (s.length..1).step(-1).each do |length|
      (0..(s.length - length)).each do |start|
        return s.slice(start, length) if palindrome?(s, start, start + length - 1)
      end
    end

    s[0]
  end
end

# Testing
# Checkout the 5_longest_palindrom_substr_test.rb
