require 'minitest/autorun'

BREAKPOINTS = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1].freeze
LETTER = %w[M CM D CD C XC L XL X IX V IV I].freeze

def int_to_roman(num)
  return nil unless num.between?(0, 3999)

  roman = []

  0.upto(BREAKPOINTS.length - 1).each do |i|
    div, mod = num.divmod(BREAKPOINTS[i])
    roman.push(LETTER[i] * div)
    num = mod
    break if num.zero?
  end

  roman.join
end

describe 'int to roman' do
  it 'converts 3999 to roman' do
    expect(int_to_roman(3999)).must_equal 'MMMCMXCIX'
  end

  it 'converts 399 to roman' do
    expect(int_to_roman(399)).must_equal 'CCCXCIX'
  end

  it 'converts 1994 to roman' do
    expect(int_to_roman(1994)).must_equal 'MCMXCIV'
  end

  it 'converts 3 to roman' do
    expect(int_to_roman(3)).must_equal 'III'
  end

  it 'converts 2 to roman' do
    expect(int_to_roman(2)).must_equal 'II'
  end

  it 'converts 1 to roman' do
    expect(int_to_roman(1)).must_equal 'I'
  end
end
