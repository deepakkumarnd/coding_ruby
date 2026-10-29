def make_params(pattern, n, m, results)
  make_params("#{pattern}(", n - 1, m, results) if n > 0
  make_params("#{pattern})", n, m - 1, results) if m > n

  results.push(pattern) if n.zero? && m.zero?
end

def generate_parenthesis(n)
  results = []
  make_params('', n, n, results)
  results
end

p generate_parenthesis(2)
p generate_parenthesis(3)
p generate_parenthesis(4)
