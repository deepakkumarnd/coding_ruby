require 'minitest/autorun'

input = %w[act pots tops cat stop hat]
output = [['hat'], %w[act cat], %w[pots tops stop]]

# expect input to contain only lowercase letters

def get_anagrams(input)
  # key => array of words
  mapping = {}

  offset = 'a'.getbyte(0)

  input.each do |word|
    counts = Array.new(26) { 0 }
    (0...word.length).each do |pos|
      counts[word.getbyte(pos) - offset] += 1
    end

    mapping[counts.join('')] ? mapping[counts.join('')].push(word) : mapping[counts.join('')] = [word]
  end

  mapping.map { |_key, value| value }.sort_by(&:length)
end

describe 'Anagram' do
  it 'produces anagram pairs from the given list' do
    result = get_anagrams(input)
    assert result == output
  end
end
