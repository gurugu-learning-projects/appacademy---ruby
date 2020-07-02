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
    self.my_any? { |ele| ele.kind_of?(Array) }
    # debugger
    # if any_arrays
    #   current = []

    #   self.my_each do |ele|
    #     if !ele.kind_of?(Array)
    #       current << ele
    #     else
    #       current.concat(ele.my_flatten)
    #     end
    #   end

    #   current
    # else
    #   return self
    # end
    self
  end
end