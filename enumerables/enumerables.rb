class Array
  def my_each(&prc)
    idx = 0
    length = self.length

    while idx < length
      self[idx] = prc.call(self[idx])
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
end