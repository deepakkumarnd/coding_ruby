def fib(n)
  return [0, n - 1].max if n <= 2

  fib(n - 1) + fib(n - 2)
end

40.times do
  p "#{it + 1} => #{fib(it + 1)}"
end
