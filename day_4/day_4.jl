
in_file = "day_4/input_4.txt"

# Read in input file as an array of strings
🟩🟥🟨  = open(in_file) do file
    readlines(file)
end

# Take string representing range and turn it into 
function string_to_array(🟩::AbstractString)
    # Find start and end of range for patch
    α, ω = parse.(Int, split(🟩, "-"))
    # Colelct range into array and return
    return collect(range(α, ω))
end



function pair_total_overlap_check(🧝🧝::String)
    # Find the squares that elf a and b are assigned to 
    🧝_a, 🧝_b, = split(🧝🧝, ",") .|> string_to_array
    # Find the intersection of their assignments
    🎄 = 🧝_a ∩ 🧝_b
    # If the intersection is equal to either, return True
    return length(🎄) == length(🧝_a) || length(🎄) == length(🧝_b)
end

function pair_partial_overlap_check(🧝🧝::String)
    # Find the squares that elf a and b are assigned to 
    🧝_a, 🧝_b, = split(🧝🧝, ",") .|> string_to_array
    # Find the intersection of their assignments
    🎄 = 🧝_a ∩ 🧝_b
    # If the intersection is equal to either, return True
    return length(🎄) > 0
end


println("The solution to part one is: ", sum(pair_total_overlap_check.(🟩🟥🟨)))
println("The solution to part two is: ", sum(pair_partial_overlap_check.(🟩🟥🟨)))