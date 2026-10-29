def swap(n1, n2)
  tmp = n2.next
  n2.next = n1
  n1.next = tmp
  n2
end

def swap_pairs(head)
  return head if head.nil? || head.next.nil?

  link = head
  tail = head.next
  tmp = tail.next

  head = swap(head, tail)

  while tmp
    n1 = tmp
    n2 = n1.next

    break if n2.nil?

    tmp = n2&.next
    link.next = swap(n1, n2)
    link = n1
  end

  head
end
