require 'minitest/autorun'
# Write a function to find the longest common prefix string
# amongst an array of strings. If there is no common prefix,
# return an empty string "".

def longest_common_prefix(strs)
  common_prefix = []

  i = 0
  word = strs.first

  loop do
    uniques = strs.map { |it| it[i] }.uniq
    break unless uniques.count == 1 && uniques != [nil]

    common_prefix.append(word[i])
    i += 1
  end

  common_prefix.join
end

def longest_common_prefix_v2(strs)
  common_prefix = []

  i = 0
  word = strs.first

  return word.to_s if word.nil? || word.empty?

  min_length = word.length

  while i < min_length
    strs.each do |str|
      min_length = str.length if i.zero? && str.length < min_length
      return common_prefix.join if str[i] != word[i]
    end

    common_prefix.append(word[i])
    i += 1
  end

  common_prefix.join
end

def longest_common_prefix_v3(strs)
  return '' if strs.empty?

  # min max is a O(n) operation instead of a
  # sort and first, last O(nlogn)
  strs.sort!
  low, high = strs.minmax
  # low = strs.first
  # high = strs.last
  i = 0
  prefix = []

  min_length = low.length < high.length ? low.length : high.length

  while i < min_length && low[i] == high[i]
    prefix.push(low[i])
    i += 1
  end

  prefix.join
end

describe 'longest common prefix' do
  it 'returns longest common prefix for "flower","flow","flight"]' do
    expect(longest_common_prefix(%w[flower flow flight])).must_equal 'fl'
  end

  it 'returns longest common prefix for "flow","flow"]' do
    expect(longest_common_prefix(%w[flow flow])).must_equal 'flow'
  end

  it 'returns empty for []' do
    expect(longest_common_prefix(%w[])).must_equal ''
  end

  it 'returns empty for [""]' do
    expect(longest_common_prefix([''])).must_equal ''
  end

  it 'returns empty for ["", "a"]' do
    expect(longest_common_prefix(['', 'a'])).must_equal ''
  end

  # v2
  it 'returns longest common prefix for "flower","flow","flight"]' do
    expect(longest_common_prefix_v2(%w[flower flow flight])).must_equal 'fl'
  end

  it 'returns longest common prefix for "flow","flow"]' do
    expect(longest_common_prefix_v2(%w[flow flow])).must_equal 'flow'
  end

  it 'returns empty for []' do
    expect(longest_common_prefix_v2(%w[])).must_equal ''
  end

  it 'returns empty for [""]' do
    expect(longest_common_prefix_v2([''])).must_equal ''
  end

  it 'returns empty for ["", "a"]' do
    expect(longest_common_prefix_v2(['', 'a'])).must_equal ''
  end

  # v3
  it 'returns longest common prefix for "flower","flow","flight"]' do
    expect(longest_common_prefix_v3(%w[flower flow flight])).must_equal 'fl'
  end

  it 'returns longest common prefix for "flow","flow"]' do
    expect(longest_common_prefix_v3(%w[flow flow])).must_equal 'flow'
  end

  it 'returns empty for []' do
    expect(longest_common_prefix_v3(%w[])).must_equal ''
  end

  it 'returns empty for [""]' do
    expect(longest_common_prefix_v3([''])).must_equal ''
  end

  it 'returns empty for ["", "a"]' do
    expect(longest_common_prefix_v3(['', 'a'])).must_equal ''
  end
end
