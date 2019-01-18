class HashSet  
  attr_accessor :count, :store

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(key)
    unless self[key].include?(key)
      self.count += 1
      resize! if self.count > num_buckets
      self[key] << key
    end
  end

  def include?(key)
    self[key].include?(key)
  end

  def remove(key)
    if self[key].include?(key)
      self.count -= 1
      self[key].delete(key)
    end
  end

  private

  def [](key)
    # optional but useful; return the bucket corresponding to `key`
    @store[key.hash % @store.length] 
  end

  def num_buckets
    @store.length
  end

  def resize!
    flattened = self.store.flatten
    @store = Array.new(2 * @store.length) {Array.new}
    flattened.each {|el| @store[el] << el}
  end
end
