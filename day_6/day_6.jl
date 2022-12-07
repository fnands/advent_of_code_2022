in_file = "day_6/input_6.txt"

# Read in input file as an array of strings
📉 = open(in_file) do file
    readline(file)
end


function get_first_repeating_n(signal::String, n::Int)
    terminator = n - 1
    for i in 1:length(📉)-terminator
        if length(unique(📉[i:i+terminator])) == n
            return i+terminator
            
        end
    end
end

println("The solution to part one is: ", get_first_repeating_n(📉, 4))
println("The solution to part two is: ", get_first_repeating_n(📉, 14))