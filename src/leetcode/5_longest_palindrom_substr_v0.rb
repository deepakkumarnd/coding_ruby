# Longest palindrom slowest version
module LongestPalindromeV0
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
  end
end
