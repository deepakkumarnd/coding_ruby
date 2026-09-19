require 'minitest/autorun'
require 'minitest/focus'
require 'benchmark'

require_relative '5_longest_palindrom_substr_v1'
require_relative '5_longest_palindrom_substr_v2'

$version = nil

def longest_palindrome(s)
  if $version == 'v1'
    LongestPalindromeV1.longest_palindrome(s)
  elsif $version == 'v2'
    LongestPalindromeV2.longest_palindrome(s)
  else
    puts 'Error - Set the $version to run the benchmark'
    exit(-1)
  end
end

module LongestPalindromTest
  extend self
  def run_tests
    describe 'Palindrome' do # rubocop:disable Metrics/BlockLength
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

      it 'A long test string' do
        s = 'cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc'
        _(longest_palindrome(s)).must_equal(s)
      end

      it 'Returns longest test string for "ccccc"' do
        s = 'ccccc'
        _(longest_palindrome(s)).must_equal(s)
      end

      it 'Returns longest test string for "abcac"' do
        s = 'abcac'
        _(longest_palindrome(s)).must_equal('cac')
      end

      it 'returns longest palindrom test string for' do
        s = 'abacdfgdcaba1234567890abcdefedcba0987654321xyzzyx'
        _(longest_palindrome(s)).must_equal('1234567890abcdefedcba0987654321')
      end
    end
  end
end

if ARGV.length >= 1 && ARGV[0] == 'benchmark'
  ARGV.push('--quiet') # run tests silently
  iterations = 1
  s = "#{'a' * 998}bc#{'a' * 996}"
  puts "Long string #{s.length}"

  Benchmark.bm(15) do |x|
    x.report 'Version 1' do
      $version = 'v1'
      iterations.times do
        puts("V1=#{longest_palindrome(s) == ('a' * 998)}")
      end
    end

    x.report 'Version 2' do
      $version = 'v2'
      iterations.times do
        puts("V2=#{longest_palindrome(s) == ('a' * 998)}")
      end
    end
  end
else
  $version = 'v1'
  LongestPalindromTest.run_tests
end
