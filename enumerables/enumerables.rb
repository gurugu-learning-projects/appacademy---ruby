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
      rejected << item unless prc.call(item)
    end

    rejected
  end

  def my_any?(&prc)
    self.my_each do |ele|
      return true if prc.call(item)
    end

    false
  end

  def my_all?(&prc)
    self.my_each do |ele|
      return false unless prc.call(item)
    end

    true
  end

  def my_flatten
    flattened = []

    self.my_each do |el|
      if el.is_a?(Array)
        flattened.concat(el.my_flatten)
      else
        flattened << el
      end
    end

    flattened
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
    split_idx = positions % self.length

    self.drop(split_idx) + self.take(split_idx)
  end

  def my_join(separator = "")
    join = ""

    self.length.times do |i|
      join += self[i]
      join += separator unless i == self.length - 1
    end

    join
  end

  def my_reverse
    reversed = []

    self.my_each do |ele|
      reversed.unshift(ele)
    end

    reversed
  end
end