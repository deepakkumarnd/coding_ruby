def sum_terms(n)
    series = Enumerator.new do |yielder|
        x = 1
        f = -> (a) { (a * a)  + 1}
        loop do
            yielder.yield f.call(x)
            x += 1        
        end
    end
    
    series.take(n).reduce(:+) || 0
end


def fn(x)
  x*x + 1
end

def _sum_terms(n)
  1.upto(n).reduce(0) do |m, x|
    m + fn(x)
  end
end

num = gets.strip.to_i

t1 = sum_terms(num)
a1 = _sum_terms(num)

unless (t1.is_a? Integer)
  puts 'Your method must return an Integer.'
  exit(0)
end

unless t1 == a1
  puts 'Ooops! Seems like you have done some mistake. Try again!'
  exit(0)
end

puts 'Kudos! Your have succesfully completed the challenge on reduce.'