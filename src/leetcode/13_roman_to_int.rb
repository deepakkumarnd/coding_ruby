require 'minitest/autorun'

# It is guaranteed that s is a valid roman numeral in the range [1, 3999].

MAPPING = {
  'I' => 1,
  'V' => 5,
  'X' => 10,
  'L' => 50,
  'C' => 100,
  'D' => 500,
  'M' => 1000
}

def roman_to_int(s)
  return if s.empty?

  i = -1
  len = s.length

  next_i = ->(i) { i + 1 < len ? i + 1 : nil }

  number = 0

  loop do
    if next_i[i] && s[next_i[i]] == 'I'
      i += 1
      n = 1
      if next_i[i] && s[next_i[i]] == 'V'
        i += 1
        n = 4
      elsif next_i[i] && s[next_i[i]] == 'X'
        i += 1
        n = 9
      end
      number += n
    elsif next_i[i] && s[next_i[i]] == 'V'
      i += 1
      n = 5
      number += n
    elsif next_i[i] && s[next_i[i]] == 'X'
      n = 10
      i += 1
      if next_i[i] && s[next_i[i]] == 'L'
        i += 1
        n = 40
      elsif next_i[i] && s[next_i[i]] == 'C'
        i += 1
        n = 90
      end
      number += n
    elsif next_i[i] && s[next_i[i]] == 'L'
      i += 1
      n = 50
      number += n
    elsif next_i[i] && s[next_i[i]] == 'C'
      n = 100
      i += 1
      if next_i[i] && s[next_i[i]] == 'D'
        i += 1
        n = 400
      elsif next_i[i] && s[next_i[i]] == 'M'
        i += 1
        n = 900
      end
      number += n
    elsif next_i[i] && s[next_i[i]] == 'D'
      i += 1
      n = 500
      number += n
    elsif next_i[i] && s[next_i[i]] == 'M'
      i += 1
      n = 1000
      number += n
    end

    break if next_i[i].nil?
  end

  number
end

def roman_to_int_v2(s)
  nil if s.empty?
  i = 0
  number = 0
  len = s.length

  while i < len
    n = 0
    if i + 1 < len
      case s[i, 2]
      when 'IV'
        n = 4
      when 'IX'
        n = 9
      when 'XL'
        n = 40
      when 'XC'
        n = 90
      when 'CD'
        n = 400
      when 'CM'
        n = 900
      end

      if n != 0
        number += n
        i += 2
        next
      end
    end

    if s[i] == 'I'
      n = 1
    elsif s[i] == 'V'
      n = 5
    elsif s[i] == 'X'
      n = 10
    elsif s[i] == 'L'
      n = 50
    elsif s[i] == 'C'
      n = 100
    elsif s[i] == 'D'
      n = 500
    elsif s[i] == 'M'
      n = 1000
    else
      raise 'Invalid roman number'
    end

    number += n
    i += 1
  end

  number
end

describe 'roman to integer' do
  it 'converts III to 3' do
    expect(roman_to_int('III')).must_equal 3
  end

  it 'converts LVIII to 58' do
    expect(roman_to_int('LVIII')).must_equal 58
  end

  it 'converts MCMXCIV to 1994' do
    expect(roman_to_int('MCMXCIV')).must_equal 1994
  end

  it 'v2 converts III to 3' do
    expect(roman_to_int_v2('III')).must_equal 3
  end

  it 'v2 converts LVIII to 58' do
    expect(roman_to_int_v2('LVIII')).must_equal 58
  end

  it 'v2 converts MCMXCIV to 1994' do
    expect(roman_to_int_v2('MCMXCIV')).must_equal 1994
  end
end
