def gamma_fn(n)
	return nil if num < 1
  return 1 if num == 1

	(num - 1) * gamma_fnc(num - 1)
end

# Test Cases
gamma_fn(0)  # => returns nil
gamma_fn(1)  # => returns 1
gamma_fn(4)  # => returns 6
gamma_fn(8)  # => returns 5040
