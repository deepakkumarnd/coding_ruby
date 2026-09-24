require 'minitest/autorun'
require 'minitest/focus'
require 'benchmark'

require_relative '5_longest_palindrom_substr_v0'
require_relative '5_longest_palindrom_substr_v1'
require_relative '5_longest_palindrom_substr_v2'
require_relative '5_longest_palindrom_substr_v3'
require_relative '5_longest_palindrom_substr_v4'

$version = nil

def longest_palindrome(s)
  target_name = "LongestPalindrome#{$version.upcase}"

  unless Kernel.const_defined? target_name
    puts "Undefined module #{target_name}"
    exit(-1)
  end

  target = Kernel.const_get(target_name)
  target.send(:longest_palindrome, s)
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

      it 'returns longest palindrom test string for "abb"' do
        s = 'abb'
        _(longest_palindrome(s)).must_equal('bb')
      end
    end
  end
end

argument = ARGV.shift

if argument == 'benchmark'
  ARGV.push('--quiet') # run tests silently
  iterations = 1
  s = "#{'a' * 998}bc#{'a' * 996}"
  puts "Long string #{s.length}"

  Benchmark.bm(15) do |x|
    %w[v0 v1 v2 v3 v4].each do |version|
      x.report "Version #{version}" do
        $version = version
        iterations.times do
          # Verify the result is true
          puts("#{version}=#{longest_palindrome(s) == ('a' * 998)}")
        end
      end
    end
  end
else
  $version = argument
  raise 'Pass version to run as argument' if $version.nil?

  LongestPalindromTest.run_tests
end
