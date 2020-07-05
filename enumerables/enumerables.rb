require "byebug"

class Array
  def my_each(&prc)
    idx = 0
    length = self.length

    while idx < length
      prc.call(self[idx])
      idx += 1
    end
    
    return self
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
end