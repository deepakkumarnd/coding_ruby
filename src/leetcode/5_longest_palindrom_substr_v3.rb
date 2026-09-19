module LongestPalindromeV3
  extend self

  def expand(s, mid)
    left = mid
    right = mid

    while left >= 0 && right < s.length
      break if s[left] != s[right]

      left -= 1
      right += 1
    end

    s[(left + 1)..(right - 1)]
  end

  def longest_palindrome(s)
    s = '#' + s.split('').join('#') + '#' # rubocop:disable Style/StringConcatenation
    longest = ''

    (0...s.length).each do |mid|
      palindrom = expand(s, mid)

      longest = palindrom if palindrom&.length > longest.length
    end

    longest.gsub('#', '')
  end
end
