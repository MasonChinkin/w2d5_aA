require 'byebug'
class Node 
  attr_reader :key
  attr_accessor :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.
  end

  # def inspect
  #   "#{object_id} #{@key}: #{@val}, prev: #{@prev}, next: #{@next}"
  # end
end

class LinkedList
  attr_reader :head, :tail, :store
  def initialize
    @head = Node.new
    @tail = Node.new
    self.tail.prev = @head
    self.head.next = @tail
    # @store = [@head, @tail]
  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    self.tail.prev
  end

  def last
    self.head.next
  end

  def empty?
    self.tail.prev == @head
    self.head.next == @tail
  end

  def get(key)
    self.store.each {|node| return node.val if node.key == key}
  end

  def include?(key)
  end

  def append(key, val)
    debugger
    new_node = Node.new(key, val)
    new_node.prev = self.tail.prev
    self.tail.prev = new_node
    new_node.next = self.tail
  end

  def update(key, val)
  end

  def remove(key)
  end

  def each
  end

  # uncomment when you have `each` working and `Enumerable` included
  # def to_s
  #   inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  # end
end
