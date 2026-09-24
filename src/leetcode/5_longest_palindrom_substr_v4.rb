# Longest palindrom optimized version
module LongestPalindromeV4
  extend self

  @rads = nil

  def longest_palindrome(s)
    return s if s.length <= 1

    # add surrounding hash to simplify boundary handling
    # convert string to an odd lengthed string and make possible palindromes to be odd lengthed.
    s = "##{s.split('').join('#')}#"
    # keep the radiuses of palindromes for each position
    @rads = Array.new(s.length) { 0 }

    max_center = 1

    (1...s.length).each do |mid|
      radius = expand(s, mid)
      max_center = mid if radius > @rads[max_center]
    end

    # take the maximum slice
    s[(max_center - @rads[max_center])..(max_center + @rads[max_center])].gsub('#', '')
  end

  def expand(s, mid)
    left = mid - 1
    right = mid + 1

    while left > 0 && right < s.length
      break if s.getbyte(left) != s.getbyte(right)

      @rads[mid] += 1

      left -= 1
      right += 1
    end

    @rads[mid]
  end
end

# Testing
# Checkout the 5_longest_palindrom_substr_test.rb
