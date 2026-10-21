require "prism"

code = <<STR
class Test
end
t = Test.new
STR
p code 

ast = Prism.parse(code)
p ast