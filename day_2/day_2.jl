

in_file = "input/input_2.txt"

# Read in input file as an array of strings
hand_shape = open(in_file) do file
    readlines(file)
end

# Define dict that maps set of hands to points won
point_dict_1 = Dict([("A X", 4), ("B X", 1), ("C X", 7),
                     ("A Y", 8), ("B Y", 5), ("C Y", 2),
                     ("A Z", 3), ("B Z", 9), ("C Z", 6)])

function one_round_1(hands::String)
    point_dict_1[hands]
end



# Define dict that maps set of hands to points won
point_dict_2 = Dict([("A X", 3), ("B X", 1), ("C X", 2),
                     ("A Y", 4), ("B Y", 5), ("C Y", 6),
                     ("A Z", 8), ("B Z", 9), ("C Z", 7)])


function one_round_2(hands::String)
    point_dict_2[hands]
end

# Use . to broadcast hand calc over vector of hands
println("The solution to part one is: ", sum(one_round_1.(hand_shape)))


# Use . to broadcast hand calc over vector of hands
println("The solution to part two is: ", sum(one_round_2.(hand_shape)))