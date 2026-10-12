require 'minitest/autorun'

input = %w[act pots tops cat stop hat]
output = [['hat'], %w[act cat], %w[pots tops stop]]

def get_anagrams(input)
  mapping = {}

  start = 'a'.getbyte(0)

  input.each do |word|
    counts = Array.new(26) { 0 }
    (0...word.length).each do |pos|
      counts[word.getbyte(pos) - start] += 1
    end

    mapping[counts.join('')] ? mapping[counts.join('')].push(word) : mapping[counts.join('')] = [word]
  end

  mapping.map do |key, value|
    value
  end.sort_by { it.length }
end

describe 'Anagram' do
  it 'produces anagram pairs from the given list' do
    result = get_anagrams(input)
    assert result == output
  end
end
