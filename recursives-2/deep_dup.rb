class Array
	def deep_dup
		self.map do |el| 
			if el.is_a? Array
				el.deep_dup
			else
				el
			end
		end
	end
end

example1 = [1, 2, 3, [1, 2, 3]]
example2 = [1, 2, 3]
example3 = [1, [2], [3, [4]]]

example1_copy = example1.deep_dup
example2_copy = example2.deep_dup
example3_copy =  example3.deep_dup

example1[3][0] = 88
example2[0] = 11
example3[2][1] = 55

p example1
p example1_copy
p example2
p example2_copy
p example3
p example3_copy