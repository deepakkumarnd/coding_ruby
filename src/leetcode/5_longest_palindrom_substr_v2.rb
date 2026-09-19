# Longest Palindrome simple version Time - O(n^3)
#
# For every length L from largest to smallest check all substrings
# to know if it is a palindrome or not. If yes return the substring.
module LongestPalindromeV2
  extend self

  def palindrome?(s, start_pos, end_pos, verified_cache)
    length = end_pos - start_pos + 1
    key = length.odd? ? :odd : :even

    mid = (start_pos + end_pos) / 2

    left, right = if verified_cache[key].key?(mid)
                    a, b = verified_cache[key][mid]
                    [a - 1, b + 1]
                  else
                    length.odd? ? [mid, mid] : [mid, mid + 1]
                  end

    while left >= start_pos && right <= end_pos
      return false if s[left] != s[right]

      verified_cache[key][mid] = [left, right]
      left -= 1
      right += 1
    end

    true
  end

  def longest_palindrome(s)
    return s if s.empty? || s.length == 1

    verified_cache = { odd: {}, even: {} }
    longest = ''

    (1..s.length).each do |length|
      (0..(s.length - length)).each do |start|
        longest = s.slice(start, length) if palindrome?(s, start, start + length - 1, verified_cache)
      end
    end

    longest
  end
end

# Testing
# Checkout the 5_longest_palindrom_substr_test.rb
