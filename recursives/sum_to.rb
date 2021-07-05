def sum_to(n)
	return nil if n < 0
	return n if n <= 1

	n + sum_to(n - 1)
end

# Test Cases
puts sum_to(5)  # => returns 15
puts sum_to(1)  # => returns 1
puts sum_to(9)  # => returns 45
p sum_to(-8)  # => returns nil
