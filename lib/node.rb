require 'pry'

class Node
  attr_reader :data
  attr_accessor :next_node

  def initialize(data)
    @data = data
    @next_node = nil
  end

  def tail?
    next_node.nil?
  end

  def to_str
    "#{@data}"
  end

end

# node = Node.new("plop")
# binding.pry
