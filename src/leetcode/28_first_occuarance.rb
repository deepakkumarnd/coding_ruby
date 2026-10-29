def str_str(haystack, needle)
  return 0 if needle.empty?

  i = 0

  haystack_len = haystack.length
  needle_len = needle.length

  while i < (haystack_len - needle_len + 1)
    return i if haystack[i, needle_len] == needle

    i += 1
  end

  -1
end

p str_str('leetcode', 'leeto')
p str_str('mississippi', 'issip')
