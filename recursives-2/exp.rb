def exp_rec_1(base, power)
	return 1 if power == 0

	base * exp_rec_1(base, power - 1)
end

def exp_rec_2(base, power)
	return 1 if power == 0

	if power.even?
		evenResult = exp_rec_2(base, power / 2)
		return evenResult * evenResult
	else
		oddResult = exp_rec_2(base, (power - 1) / 2)
		return base * (oddResult * oddResult)
	end
end

# Examples
p exp_rec_2(0, 0)
p exp_rec_2(0, 1)
p exp_rec_2(1, 0)
p exp_rec_2(1, 1)
p exp_rec_2(1, 2)
p exp_rec_2(2, 0)
p exp_rec_2(2, 1)
p exp_rec_2(2, 2)