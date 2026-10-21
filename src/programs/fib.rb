require 'benchmark'

def fib_recur(n)
  return 0 if n.zero? || n.negative?
  return 1 if n == 1 || n == 2 # rubocop:disable Style/MultipleComparison

  fib_recur(n - 1) + fib_recur(n - 2)
end

def fib_tailrec(n, a = 0, b = 1)
  return 0 if n.zero? || n.negative?
  return b if n == 1

  fib_tailrec(n - 1, b, a + b)
end

def iter_fib(n)
  return 0 if n.zero? || n.negative?

  a = 0
  b = 1

  n.times do
    c = a + b
    a = b
    b = c
  end

  a
end

def fib_lazy_iter
  Enumerator.new do |yielder|
    a = 0
    b = 1

    loop do
      c = a + b
      a = b
      b = c

      yielder.yield a
    end
  end
end

40.times do
  # p "#{it + 1} => #{fib_recur(it + 1)}"
  # p "#{it + 1} => #{iter_fib(it + 1)}"
  # p "#{it + 1} => #{fib_tailrec(it + 1)}"
end

# fib_lazy_iter.take(40).each_with_index do |num, index|
#   p "#{index + 1} => #{num}"
# end

benchmark = true

benchmark && Benchmark.bm do |x|
  x.report('fib_recur') do
    40.times do
      fib_recur(it + 1)
    end
  end

  x.report('fib_tailrec') do
    40.times do
      fib_tailrec(it + 1)
    end
  end

  x.report('fib_iter') do
    40.times do
      iter_fib(it + 1)
    end
  end

  x.report('fib_lazy_iter') do
    fib_lazy_iter.take(40).to_a
  end
end
