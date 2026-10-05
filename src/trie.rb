class TrieNode
  attr_accessor :value, :child_nodes

  def initialize(value: nil)
    @child_nodes = Array.new(26) { nil }
    @value = value
  end

  def leafnode?
    !!value
  end

  def clear!
    @value = nil
  end
end

class Trie
  attr_reader :word_count, :nodes_count

  OFFSET = 'a'.getbyte(0).freeze

  def initialize
    @word_count = 0
    @nodes_count = 1
    @root_node = TrieNode.new
  end

  private def to_index(byte)
    byte - OFFSET
  end

  def insert(word, value = nil)
    temp_node = @root_node

    word.each_byte.map { |byte| to_index(byte) }.each do |index|
      if temp_node.child_nodes[index].nil?
        temp_node.child_nodes[index] = TrieNode.new
        @nodes_count += 1
      end

      temp_node = temp_node.child_nodes[index]
    end

    return if temp_node.value

    temp_node.value = word

    @word_count += 1
  end

  def has?(word)
    traverse_with(word) do |lastnode|
      !!lastnode&.leafnode?
    end
  end

  def has_prefix?(word)
    traverse_with(word) do |lastnode|
      !!lastnode
    end
  end

  def find(word)
    traverse_with(word) do |lastnode|
      lastnode.value if lastnode&.leafnode?
    end
  end

  def remove(word)
    temp_node = @root_node

    nodes_to_delete = []

    word
      .each_byte
      .map { |byte| to_index(byte) }
      .each do |index|
        break if temp_node.leafnode? || temp_node.child_nodes[index].nil?

        nodes_to_delete.push(temp_node) if temp_node.child_nodes[index]

        temp_node = temp_node.child_nodes[index]
      end

    return nil unless temp_node.leafnode?

    temp_node = nodes_to_delete.pop

    while temp_node && temp_node.child_nodes.count { |c| !c.nil? } <= 1
      temp_node.child_nodes = Array.new(26) { nil }
      @nodes_count -= 1
      temp_node = nodes_to_delete.pop
    end

    @word_count -= 1
  end

  def each(&block)
    each_iter(@root_node, &block)
  end

  def each_iter(temp_node, &block)
    temp_node.child_nodes.each do |v|
      next if v.nil?

      if v.leafnode?
        block.call(v.value)
      else
        each_iter(v, &block)
      end
    end
  end

  def each_node_iter(temp_node, &block)
    temp_node.child_nodes.each do |v|
      next if v.nil?

      if v.leafnode?
        block.call(v)
      else
        each_node_iter(v, &block)
      end
    end
  end

  def to_array
    values = []

    each_iter(@root_node) do |value|
      values.push(value)
    end

    values
  end

  def self.from_array(array)
    trie = Trie.new

    array.each do |word|
      trie.insert(word)
    end

    trie
  end

  private def traverse_with(word, &loop_block)
    temp_node = @root_node

    word.each_byte
        .map { |byte| to_index(byte) }
        .each do |index|
      temp_node = temp_node.child_nodes[index]
      break if temp_node.nil?

      loop_block&.call(temp_node)
    end

    yield(temp_node) if block_given?
  end
end
