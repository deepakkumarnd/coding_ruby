require 'minitest/autorun'

def max_area(heights)
  len = heights.length

  max_area = 0

  0.upto(len - 2).each do |i|
    (i + 1).upto(len - 1).each do |j|
      area = [heights[i], heights[j]].min * (j - i)
      max_area = area if area > max_area
    end
  end

  max_area
end

def max_area_v2(heights)
  l = 0
  r = heights.length - 1

  max_area = 0

  while l < r
    height = [heights[l], heights[r]].min
    width = r - l
    area = height * width
    max_area = area if area > max_area

    if heights[l] <= heights[r]
      l += 1
      l += 1 while l < r && heights[l] < height
    else
      r -= 1
      r -= 1 while l < r && heights[r] < height
    end
  end

  max_area
end

describe 'returns max area' do
  it 'returns the max area for [1,8,6,2,5,4,8,3,7]' do
    expect(max_area([1, 8, 6, 2, 5, 4, 8, 3, 7])).must_equal 49
  end

  it 'returns the max area for [8,7,2,1]' do
    expect(max_area([8, 7, 2, 1])).must_equal 7
  end

  it 'v2 returns the max area for [1,8,6,2,5,4,8,3,7]' do
    expect(max_area_v2([1, 8, 6, 2, 5, 4, 8, 3, 7])).must_equal 49
  end

  it 'v2 returns the max area for [8,7,2,1]' do
    expect(max_area_v2([8, 7, 2, 1])).must_equal 7
  end
end
