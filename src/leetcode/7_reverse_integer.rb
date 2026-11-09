def reverse(x)
  y = 0
  sign = x.negative? ? -1 : 1
  x = x.abs

  while x > 0
    dig = x % 10
    y = y * 10 + dig
    x /= 10
  end

  sign * y
end

p reverse(0)
p reverse(9)
p reverse(10)
p reverse(123)
p reverse(-234)
p reverse(1_534_236_469)
