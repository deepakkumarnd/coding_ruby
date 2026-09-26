# Longest palindrom optimized version
module LongestPalindromeV4
  def padded_input(s)
    pad = '#'
    s = s.split('').join(pad)
    "#{pad}#{s}#{pad}"
  end

  def unpad(s)
    s.gsub('#', '')
  end

  def expand(s, mid, rads)
    left = mid - 1
    right = mid + 1

    while (left > 0) && (right < s.length) && (s.getbyte(left) == s.getbyte(right))
      rads[mid] += 1
      left -= 1
      right += 1
    end

    rads[mid]
  end

  def longest_palindrome(s)
    return s if s.length <= 1

    s = padded_input(s)

    rads = Array.new(s.length) { 0 }

    longest_pos = 0

    (1...s.length - 1).each do |pos|
      radius = expand(s, pos, rads)
      longest_pos = pos if radius > rads[longest_pos]
    end

    unpad(s[(longest_pos - rads[longest_pos])..(longest_pos + rads[longest_pos])])
  end
end

LongestPalindromeV4.extend(LongestPalindromeV4)

# Testing
# Checkout the 5_longest_palindrom_substr_test.rb
