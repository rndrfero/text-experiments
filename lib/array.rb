class Array
  def rand
    return nil if empty?
    self[Random.rand self.length].gsub(/-/,' ')
  end
end
