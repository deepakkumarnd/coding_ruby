require 'minitest/autorun'

# You are given two non-empty linked lists representing two non-negative integers.
# The digits are stored in reverse order, and each of their nodes contains a
# single digit. Add the two numbers and return the sum as a linked list.

# You may assume the two numbers do not contain any leading zero, except the number 0 itself.
#
# Time:  O(n) - Depends on the longest list length we are traversing entire length of the lists once.
# Space: O(n) - The result list can grow upto longest list length plus one.
ListNode = Struct.new(:val, :next)

def list_node(num)
  dummy = ListNode.new(0)
  tail = dummy

  while num.positive?
    digit = num % 10
    num /= 10
    tail.next = ListNode.new(digit, nil)
  end

  dummy.next
end

def add_two_numbers(l1, l2)
  dummy = ListNode.new(0)
  tail = dummy
  carry = 0

  while l1 || l2 || carry.positive?
    digit, carry = node_sum(l1, l2, carry)
    tail.next = ListNode.new(digit)
    tail = tail.next
    l1 = l1&.next
    l2 = l2&.next
  end

  dummy.next
end

def node_sum(node1, node2, carry)
  sum = (node1&.val || 0) + (node2&.val || 0) + (carry || 0)
  [sum % 10, sum / 10]
end

# Test for add two numbers
describe 'Add two numbers as list' do
  it 'Evaluates 321 + 3 = 621' do
    l1 = ListNode.new(3, ListNode.new(2, ListNode.new(1, nil)))
    l2 = ListNode.new(3, nil)
    l3 = ListNode.new(6, ListNode.new(2, ListNode.new(1, nil)))

    _(add_two_numbers(l1, l2)).must_equal(l3)
  end

  it 'Evaluates 246 + 464 = 608' do
    l1 = ListNode.new(2, ListNode.new(4, ListNode.new(3, nil)))
    l2 = ListNode.new(4, ListNode.new(6, ListNode.new(4, nil)))
    l3 = ListNode.new(6, ListNode.new(0, ListNode.new(8, nil)))

    _(add_two_numbers(l1, l2)).must_equal(l3)
  end

  it 'Evaluates 246 + nil = 246' do
    l1 = ListNode.new(2, ListNode.new(4, ListNode.new(3, nil)))
    l2 = nil
    _(add_two_numbers(l1, l2)).must_equal(l1)
  end

  it 'Evaluates nil + 246 = 246' do
    l1 = nil
    l2 = ListNode.new(2, ListNode.new(4, ListNode.new(3, nil)))
    _(add_two_numbers(l1, l2)).must_equal(l2)
  end

  it 'Evaluates 9 + 1 = 10' do
    l1 = ListNode.new(9, nil)
    l2 = ListNode.new(1, nil)
    l3 = ListNode.new(0, ListNode.new(1, nil))
    _(add_two_numbers(l1, l2)).must_equal(l3)
  end

  it 'Evaluates 291 + 10 = 301' do
    l1 = list_node(291)
    l2 = list_node(10)
    l3 = list_node(301)
    _(add_two_numbers(l1, l2)).must_equal(l3)
  end

  it 'Evaluates 9 + 0 = 9' do
    l1 = list_node(9)
    l2 = list_node(0)
    l3 = list_node(9)
    _(add_two_numbers(l1, l2)).must_equal(l3)
  end
end
