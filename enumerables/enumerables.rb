require "byebug"

class Array
  def my_each(&prc)
    self.length.times do |i|
      prc.call(self[i])
    end

    self
  end

  def my_select(&prc)
    selected = []

    self.my_each do |ele|
      if prc.call(ele)
        selected << ele
      end
    end

    selected
  end

  def my_reject(&prc)
    rejected = []

    self.my_each do |ele|
      if !prc.call(ele)
        rejected << ele
      end
    end

    rejected
  end

  def my_any?(&prc)
    self.my_each do |ele|
      if prc.call(ele)
        return true
      end
    end

    false
  end

  def my_all?(&prc)
    self.my_each do |ele|
      if !prc.call(ele)
        return false
      end
    end

    true
  end

  def my_flatten
    any_arrays = self.my_any? { |ele| ele.kind_of?(Array )}
    # debugger

    if any_arrays
      current = []

      self.my_each do |ele|
        if ele.kind_of?(Array)
          current.concat(ele.my_flatten)
        else
          current << ele
        end
      end

      return current
    else
      return self
    end
  end

  def my_zip(*args)
    new_arr = []

    self.each_with_index do |ele, idx|
      current = []
      current << ele

      args.my_each do |arr|
        if arr[idx]
          current << arr[idx]
        else
          current << nil
        end
      end

      new_arr << current
    end

    new_arr
  end

  def my_rotate(count = 1)
    rotated = []

    self.each_with_index do |ele, idx|
      difference = idx - count
      new_idx = difference.abs >= self.length ? difference % self.length : difference

      if new_idx < 0
        new_idx = self.length + new_idx
      end

      rotated[new_idx] = ele
    end

    rotated
  end

  def my_join(separator = "")
    joined_string = ""

    self.each_with_index do |ele, idx|
      joined_string += ele.to_s

      if idx != self.length - 1
        joined_string += separator.to_s
      end
    end

    joined_string
  end

  def my_reverse
    reversed = []

    self.my_each do |ele|
      reversed.unshift(ele)
    end

    reversed
  end
end