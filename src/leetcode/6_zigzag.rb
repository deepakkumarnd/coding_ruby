# The string "PAYPALISHIRING" is written in a zigzag pattern
# on a given number of rows like this: (you may want to display
# this pattern in a fixed font for better legibility)

# P   A   H   N
# A P L S I I G
# Y   I   R
# And then read line by line: "PAHNAPLSIIGYIR"

# Write the code that will take a string and make this conversion given a number of rows:
# For zig zag pattern like this for number of rows n, there would be 2*(n-1) chars per
# repeating pattern. We need L/2 number of columns to fit in all chars. Where L is the length
# of the string.
# Chars per patter = 2n - 2
# Columns needed per pattern = n - 1
#
# no column = L/(2*(n-1))*(n-1) = L/2

def convert(s, num_rows)
  return s if num_rows <= 1

  lists = Array.new(num_rows) { Array.new(s.length / 2) { ' ' } }

  row = 0
  column = 0
  direction = -1

  s.each_char do |ch|
    lists[row][column] = ch
    direction = -1 * direction if row.zero? || row == num_rows - 1
    row += direction
    column += 1 if direction.negative?
  end

  lists.each do |l|
    p l
  end

  lists.flatten.join.gsub(' ', '')
end

p convert('PAYPALISHIRING', 3) == 'PAHNAPLSIIGYIR'
convert('PAYPALISHIRING', 3)
p convert('AB', 1) == 'AB'
