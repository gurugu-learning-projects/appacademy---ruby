def range(startNum, endNum)
	return [] if startNum >= endNum

	range(startNum, endNum - 1) << endNum - 1
end

def rangeIterative(startNum, endNum)
	range = []

	(startNum...endNum).each do |num|
		range << num
	end

	range
end

# Examples
p range(1, 5)
p rangeIterative(1, 5)