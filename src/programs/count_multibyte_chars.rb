def count_multibyte_char(str)
    multibyte_char_count = 0
    
    str.each_codepoint do |codepoint|
      multibyte_char_count += 1 if codepoint > 127
    end
    
    multibyte_char_count
end

p count_multibyte_char("മലയാളം")
p "മലയാളം".length
p "മലയാളം".each_char.to_a