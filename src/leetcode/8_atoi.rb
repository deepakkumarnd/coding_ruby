def my_atoi(s)
  return 0 if s.empty?

  i = 0

  low = '0'.getbyte(0)
  high = '9'.getbyte(0)
  num = nil
  sign = nil

  (0...s.length).each do |i|
    # skip whitespace
    next if num.nil? && s[i] == ' '

    if num.nil? && s[i] == '-'
      sign = -1
      num = 0
      next
    end

    num ||= 0
    sign ||= 1

    byte = s.getbyte(i)
    break unless byte >= low && byte <= high

    num = num * 10 + (byte - low)
  end

  sign * num
end

p my_atoi('123s')

p my_atoi('-123s')

p my_atoi(' -123s')

p my_atoi('  - 123s')
