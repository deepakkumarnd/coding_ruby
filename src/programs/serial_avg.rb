def serial_average(str)
    serial = str[0,3]
    first_number = str[4, 5].to_f
    second_number = str[10, 5].to_f
    avg = ((first_number + second_number) / 2).round(2)
    "#{serial}-%.2f" % avg
end

def serial_average2(str)
    splits = str.split('-')
    serial = splits[0]
    first_number = splits[1].to_f
    second_number = splits[2].to_f
    avg = ((first_number + second_number) / 2).round(2)
    "#{serial}-%.2f" % avg
end

def serial_average3(str)
    serial = str.slice(0, 3)
    first_number = str.slice(4, 5).to_f
    second_number = str.slice(10, 5).to_f
    avg = ((first_number + second_number) / 2).round(2)
    "#{serial}-%.2f" % avg
end



p serial_average("002-10.00-20.00") === "002-15.00"
p serial_average2("002-10.00-20.00") === "002-15.00"
p serial_average3("002-10.00-20.00") === "002-15.00"