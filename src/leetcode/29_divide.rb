def divide(dividend, divisor)
  return if divisor.zero?

  sign = if dividend.negative? && divisor.negative?
           1
         elsif dividend.negative? || divisor.negative?
           -1
         else
           1
         end

  dividend = dividend.abs
  divisor = divisor.abs

  if divisor == 1
    return sign.negative? ? -dividend : dividend
  elsif dividend.zero?
    return 0
  end

  d = 0

  while dividend >= divisor
    dividend -= divisor
    d += 1
  end

  sign.negative? ? -d : d
end

p divide(10, 3)
p divide(1, 1)
p divide(1, 0)
p divide(-2_147_483_648, -1)
