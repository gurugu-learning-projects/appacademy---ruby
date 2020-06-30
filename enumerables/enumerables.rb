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
end