def add_numbers(n)
	return n.first if n.length < 2
	n.first + add_numbers(n[1..-1])
end

# Test Cases
p add_numbers([1,2,3,4]) # => returns 10
p add_numbers([3]) # => returns 3
p add_numbers([-80,34,7]) # => returns -39
p add_numbers([]) # => returns nil
