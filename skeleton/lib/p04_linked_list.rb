require 'byebug' 
class Node 
  attr_reader :key
  attr_accessor :val, :next, :prev

  include Enumerable

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
end

class LinkedList
  attr_reader :head, :tail, :store
  include Enumerable
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
    self.each do |node|
      return node.val if node.key == key
    end
    nil
  end

  def include?(key)
    self.each do |node|
      return true if node.key == key
    end
    false
  end

  def append(key, val)
    new_node = Node.new(key, val)
    # byebug
    new_node.prev = self.head
    new_node.next = self.head.next
    new_node.next.prev = new_node
    self.head.next = new_node
    self.tail.prev = new_node if self.tail.prev == self.head
  end

  def update(key, val)
    self.each do |node|
      if  node.key == key
        node.val = val
      end
    end
  end

  def remove(key)

  end

  def each(&prc)
    current = self.tail.prev
    
    until current == self.head
      prc.call(current)
      current = current.prev
    end
    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
