require 'minitest/autorun'
# Given a string containing digits from 2-9 inclusive, return all possible
# letter combinations that the number could represent.
# Return the answer in any order.

MAPPING = {
  2 => %w[a b c],
  3 => %w[d e f],
  4 => %w[g h i],
  5 => %w[j k l],
  6 => %w[m n o],
  7 => %w[p q r s],
  8 => %w[t u v],
  9 => %w[w x y z]
}.freeze

def letter_combinations(digits)
  combine = lambda do |arr1, arr2|
    return arr2 if arr1.empty?
    return arr1 if arr2.empty?

    arr1.map do |e1|
      arr2.map do |e2|
        [e1, e2].join
      end
    end.flatten
  end

  combinations = []
  digits.each_char do |char|
    letters = MAPPING[char.to_i] || []
    combinations = combine.call(combinations, letters)
  end

  combinations
end

describe 'Letter combinations' do
  it 'combines letters for 23' do
    expect(letter_combinations('23')).must_equal %w[ad ae af bd be bf cd ce cf]
  end

  it 'combines letters for 2' do
    expect(letter_combinations('2')).must_equal %w[a b c]
  end

  it 'combines letters for 0' do
    expect(letter_combinations('0')).must_equal []
  end

  it 'combines letters for 9' do
    expect(letter_combinations('9')).must_equal %w[w x y z]
  end

  it 'combines letters for 91' do
    expect(letter_combinations('9')).must_equal %w[w x y z]
  end

  it 'combines letters for 19' do
    expect(letter_combinations('9')).must_equal %w[w x y z]
  end
end
