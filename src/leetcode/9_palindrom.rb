require 'minitest/autorun'

def is_palindrome(x)
  return false if x.negative?

  x = x.to_s

  i = 0
  j = x.length - 1

  while i < j
    return false unless x[i] == x[j]

    i += 1
    j -= 1
  end

  true
end

def is_palindrome(x)
  return false if x.negative?

  orig_x = x
  queue = []

  while x > 0
    div, mod = x.divmod(10)
    queue.push(mod)
    x = div
  end

  x_bar = 0

  x_bar = x_bar * 10 + queue.shift until queue.empty?

  orig_x == x_bar
end

describe 'Palindrom' do
  it 'return true for 0' do
    expect(is_palindrome(0)).must_equal true
  end

  it 'return true for 9' do
    expect(is_palindrome(9)).must_equal true
  end

  it 'return true for 10' do
    expect(is_palindrome(10)).must_equal false
  end

  it 'return true for -10' do
    expect(is_palindrome(-10)).must_equal false
  end

  it 'return true for 10001' do
    expect(is_palindrome(10_001)).must_equal true
  end

  it 'return true for 1001' do
    expect(is_palindrome(1001)).must_equal true
  end

  it 'return true for 10101' do
    expect(is_palindrome(10_101)).must_equal true
  end

  it 'return true for 12122' do
    expect(is_palindrome(12_122)).must_equal false
  end
end
