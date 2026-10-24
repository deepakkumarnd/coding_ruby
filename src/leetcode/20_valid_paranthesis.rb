PAIR = {
  '}' => '{',
  ')' => '(',
  ']' => '['
}.freeze

def is_valid(s)
  stack = []
  s.each_char do |ch|
    if ['[', '(', '{'].include? ch
      stack.push(ch)
    elsif [']', ')', '}'].include? ch
      return false unless stack.pop == PAIR[ch]
    else
      return false
    end
  end

  stack.empty?
end
