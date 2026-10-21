def strike(str)
    "<strike>#{str}</strike>"
end

def mask_article(str, words)
    words.each do |word|
        str.gsub!(word, strike(word)) if str.include? word
    end
    
    str
end


p mask_article("Hello World! This is crap!", ["crap"])