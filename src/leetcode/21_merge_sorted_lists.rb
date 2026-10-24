def merge_two_lists(list1, list2)
  return list1 || list2 if list1.nil? || list2.nil?

  tmp1 = list1
  tmp2 = list2

  if tmp1.val <= tmp2.val
    head = tmp1
    tmp1 = tmp1.next
  else
    head = tmp2
    tmp2 = tmp2.next
  end

  tmp = head

  while tmp1 && tmp2
    if tmp1.val <= tmp2.val
      tmp.next = tmp1
      tmp1 = tmp1.next
    else
      tmp.next = tmp2
      tmp2 = tmp2.next
    end

    tmp = tmp.next
  end

  tmp.next = tmp1 || tmp2

  head
end
