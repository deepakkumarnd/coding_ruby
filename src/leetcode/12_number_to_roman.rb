require 'minitest/autorun'

def int_to_roman(num)
  return nil unless num.between?(0, 3999)

  roman = []

  while num.positive?
    if num >= 1000
      roman.push('M')
      num -= 1000
    elsif num >= 900
      roman.push('CM')
      num -= 900
    elsif num >= 500
      roman.push('D')
      num -= 500
    elsif num >= 400
      roman.push('CD')
      num -= 400
    elsif num >= 100
      roman.push('C')
      num -= 100
    elsif num >= 90
      roman.push('XC')
      num -= 90
    elsif num >= 50
      roman.push('L')
      num -= 50
    elsif num >= 40
      roman.push('XL')
      num -= 40
    elsif num >= 10
      roman.push('X')
      num -= 10
    elsif num == 9
      roman.push('IX')
      num -= 9
    elsif num >= 5
      roman.push('V')
      num -= 5
    elsif num == 4
      roman.push('IV')
      num -= 4
    elsif num >= 1
      roman.push('I')
      num -= 1
    end
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
