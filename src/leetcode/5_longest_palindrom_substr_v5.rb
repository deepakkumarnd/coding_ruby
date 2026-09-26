module LongestPalindromeV5
  def longest_palindrome(s) # rubocop:disable Metrics/AbcSize
    return s if s.length <= 1

    s = padded_input(s)

    rads = Array.new(s.length) { 0 }
    center = 0
    right_boundary = 0

    longest_pos = 0

    (1...s.length - 1).each do |pos|
      if pos < right_boundary
        mirror_pos = 2 * center - pos
        rads[pos] = [rads[mirror_pos], right_boundary - pos].min
      else
        center = pos
        right_boundary = pos
      end

      radius = expand(s, pos, rads)
      right_boundary = pos + radius if pos + radius > right_boundary
      longest_pos = pos if radius > rads[longest_pos]
    end

    unpad(s[(longest_pos - rads[longest_pos])..(longest_pos + rads[longest_pos])])
  end

  def padded_input(s)
    pad = '#'
    s = s.split('').join(pad)
    "#{pad}#{s}#{pad}"
  end

  def unpad(s)
    s.gsub('#', '')
  end

  def expand(s, pos, rads)
    left = pos - rads[pos] - 1
    right = pos + rads[pos] + 1

    while (left >= 0) && (right < s.length) && (s.getbyte(left) == s.getbyte(right))
      rads[pos] += 1
      left -= 1
      right += 1
    end

    rads[pos]
  end
end

LongestPalindromeV5.extend(LongestPalindromeV5)

# Testing
# Checkout the 5_longest_palindrom_substr_test.rb
