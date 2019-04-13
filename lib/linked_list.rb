require 'pry'
require './lib/node'

class LinkedList
  attr_reader :head

  def initialize
    @head = nil
  end

  def append(data)
    if empty?
      set_head(data)
    else
      set_tail(data)
    end
  end

  def prepend(data)
    node = Node.new(data)
    node.next_node = @head
    @head = node
  end

  def insert(position, data)
    node = new_node(data)
    prior_node = node_at(head, position - 1)
    next_node = node_at(head, position)
    prior_node.next_node = node
    node.next_node = next_node
    return node
  end

  def new_node(data)
    Node.new(data)
  end

  def count
    if head == nil
      0
    else
      count_node(@head, 1)
    end
  end

  def to_string
    if empty?
      ""
    elsif head.tail?
      "#{head.data}"
    else
      add_to_string(head.next_node, "#{head.data}")
    end
  end

  def last_node(node)
    return node if node.tail?
    last_node(node.next_node)
  end

  def empty?
    @head.nil?
  end

  def find(start, count)
    found_node = node_at(head, start)
    sentence = found_node.to_str
    if count == 1
      sentence
    else
      add_to_string(found_node.next_node, sentence, count -= 1)
    end
  end

  def includes?(data)
    find_by_surname(@head, data)
  end

  def pop
    new_tail = node_at(head, count - 2)
    old_tail = new_tail.next_node
    new_tail.next_node = nil
    return old_tail
  end

  private

    def set_head(data)
      @head = new_node(data)
    end

    def set_tail(data)
      last_node(head).next_node = new_node(data)
    end

    def count_node(node, counter)
      return counter if node.tail?
      count_node(node.next_node, counter += 1)
    end

    def add_one_to_string(sentence, node)
      "#{sentence} #{node.data}"
    end

    def add_to_string(node, sentence, terminal=nil, counter=1)
      current_response = add_one_to_string(sentence, node)

      if node.tail? || terminal == counter
        current_response
      else
        add_to_string(node.next_node, add_one_to_string(sentence, node), terminal, counter += 1)
      end
    end

    def node_at(node, position, counter=0)
      if position == counter
        node
      else
        node_at(node.next_node, position, counter += 1)
      end
    end

    def find_by_surname(node, data)
      return true if node.data == data
      return false if node.tail?
      find_by_data(node.next_node, data)
    end
end

list = LinkedList.new
list.append("doop")
binding.pry

# > list.includes?("deep")
# => true
# > list.includes?("dep")
# => false
# > list.pop
# => "blop"
# > list.pop
# => "shu"
# > list.to_string
# => "deep woo shi"
