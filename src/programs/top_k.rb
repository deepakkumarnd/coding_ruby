
def top_k(customers)
    customers.filter { |cust| cust[:status] == 'completed' }
        .group_by { |cust| cust[:customer_id] }
        .map { |id, records| [id, records.map { |cust| cust[:amount] }.sum] }
        .sort_by { |pair| pair.last }
        .last(3)
        .map(&:first)
        .reverse
end

sample = [
    { customer_id: 1, amount: 100, status: 'completed' },
    { customer_id: 1, amount: 50, status: 'completed' },
    { customer_id: 1, amount: 20, status: 'pending' }, 
    { customer_id: 2, amount: 20, status: 'completed' },
    { customer_id: 3, amount: 500, status: 'completed' },
    { customer_id: 2, amount: 5000, status: 'pending' },
    { customer_id: 4, amount: 5000, status: 'completed' }]

p top_k(sample)