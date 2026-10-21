require 'minitest/autorun'

# Given the head of a linked list, remove the nth node
# from the end of the list and return its head.
class ListNode
  attr_accessor :val, :next

  def initialize(val = 0, next_node = nil)
    @val = val
    @next = next_node
  end

  def to_s
    self.next ? "[#{val},#{self.next}]" : "[#{val}]"
  end
end

def remove_nth_from_end(head, n)
  return if head.nil?
  return head if n.zero? || n.negative?

  n_1th = current = head
  len = 1

  loop do
    current = current.next

    break if current.nil?

    len += 1
    n_1th = n_1th.next if len > (n + 1)
  end

  if len < n
    head
  elsif len == n
    head.next
  else
    n_1th.next = n_1th.next.next
    head
  end
end

def build_list(values)
  return if values.empty?

  head = ListNode.new(values.first)

  values.drop(1).inject(head) do |tail, el|
    new_node = ListNode.new(el)
    tail.next = new_node
    new_node
  end

  head
end

def to_array(head)
  array = []

  while head
    array.push(head.val)
    head = head.next
  end

  array
end

describe 'empty list' do
  it "Can't remove anything from an empty list" do
    list = build_list([])
    head = remove_nth_from_end(list, 1)
    expect(to_array(head)).must_equal []
  end

  it 'No change when n = 0' do
    list = build_list([])
    head = remove_nth_from_end(list, 0)
    expect(to_array(head)).must_equal []
  end
end

describe 'one member list' do
  it 'remove the single element' do
    list = build_list([1])
    head = remove_nth_from_end(list, 1)
    expect(to_array(head)).must_equal []
  end

  it 'No change when n = 0' do
    list = build_list([1])
    head = remove_nth_from_end(list, 0)
    expect(to_array(head)).must_equal [1]
  end

  it 'No change when n = -3' do
    list = build_list([1])
    head = remove_nth_from_end(list, -3)
    expect(to_array(head)).must_equal [1]
  end

  it 'No change when n > length of list' do
    list = build_list([1])
    head = remove_nth_from_end(list, 3)
    expect(to_array(head)).must_equal [1]
  end
end

describe 'two member list' do
  it 'remove the single element when n = 1' do
    list = build_list([1, 2])
    head = remove_nth_from_end(list, 1)
    expect(to_array(head)).must_equal [1]
  end

  it 'remove the single element when n = 2' do
    list = build_list([1, 2])
    head = remove_nth_from_end(list, 2)
    expect(to_array(head)).must_equal [2]
  end

  it 'No change when n = 0' do
    list = build_list([1, 2])
    head = remove_nth_from_end(list, 0)
    expect(to_array(head)).must_equal [1, 2]
  end

  it 'No change when n = -3' do
    list = build_list([1, 2])
    head = remove_nth_from_end(list, -3)
    expect(to_array(head)).must_equal [1, 2]
  end

  it 'No change when n > length of list' do
    list = build_list([1, 2])
    head = remove_nth_from_end(list, 4)
    expect(to_array(head)).must_equal [1, 2]
  end
end

describe 'more than two member list' do
  it 'remove the single element when n = 1' do
    list = build_list([1, 2, 3])
    head = remove_nth_from_end(list, 1)
    expect(to_array(head)).must_equal [1, 2]
  end

  it 'remove the single element when n = 2' do
    list = build_list([1, 2, 3])
    head = remove_nth_from_end(list, 2)
    expect(to_array(head)).must_equal [1, 3]
  end

  it 'remove the single element when n = 3' do
    list = build_list([1, 2, 3])
    head = remove_nth_from_end(list, 3)
    expect(to_array(head)).must_equal [2, 3]
  end

  it 'No change when n = 0' do
    list = build_list([1, 2, 3])
    head = remove_nth_from_end(list, 0)
    expect(to_array(head)).must_equal [1, 2, 3]
  end

  it 'No change when n = -1' do
    list = build_list([1, 2, 3])
    head = remove_nth_from_end(list, -1)
    expect(to_array(head)).must_equal [1, 2, 3]
  end

  it 'No change when n > length of list' do
    list = build_list([1, 2, 3])
    head = remove_nth_from_end(list, 4)
    expect(to_array(head)).must_equal [1, 2, 3]
  end

  it 'Removes nth element' do
    list = build_list([1, 2, 3, 4, 5])
    head = remove_nth_from_end(list, 3)
    expect(to_array(head)).must_equal [1, 2, 4, 5]
  end
end
