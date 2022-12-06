in_file = "day_6/input_6.txt"

# Read in input file as an array of strings
📉 = open(in_file) do file
    readline(file)
end


for i in 1:length(📉)-3
    
    if length(unique(📉[i:i+3])) == 4
        println(i+3)
        break
    end
end


for i in 1:length(📉)-13
    
    if length(unique(📉[i:i+13])) == 14
        println(📉[i:i+13])
        println(i)
        println(📉[i+13])
        println(i+13)
        break
    end
end