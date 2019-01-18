require 'byebug'
class MaxIntSet
  attr_reader :store, :max
  def initialize(max)
    @max = max
    @store = Array.new(max) {false}
  end

  def insert(num)
    raise "Out of bounds" if num > max || num < 0
    self.store[num] = true
  end

  def remove(num)
    self.store[num] = false
  end

  def include?(num)
    self.store[num]
  end
end


class IntSet
  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
  end

  def insert(num)
    # i = num % self.store.length
    self[num] << num if !self[num].include?(num)
  end

  def remove(num)
    self[num].reject! {|el| el == num}
  end

  def include?(num)
    self[num].any? {|el| el == num}
  end

  private

  def [](num)
    @store[num % num_buckets]
  end

  def num_buckets
    @store.length
  end
end

class ResizingIntSet
  attr_accessor :count, :store

  def initialize(num_buckets = 20)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    unless self[num].include?(num)
      self.count += 1
      resize! if self.count > num_buckets
      self[num] << num
    end
  end

  def remove(num)
    if self[num].include?(num)
      self.count -= 1
      self[num].delete(num)
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    @store[num % @store.length]  
  end

  def num_buckets
    self.store.length
  end

  def resize!
    # @store += Array.new(@store.length) {Array.new}
    flattened = self.store.flatten
    @store = Array.new(2 * @store.length) {Array.new}
    flattened.each {|el| @store[el] << el}
  end
end
