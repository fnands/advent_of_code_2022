
in_file = "day_3/input_3.txt"

# Read in input file as an array of strings
all_contents = open(in_file) do file
    readlines(file)
end

# Define arrays of letter and numbers
lower = collect('a':'z')
upper = collect('A':'Z')
letters = vcat(lower, upper)
values = collect(1:52)

# Turn arrays into a dict
point_dict = Dict(letters .=> values)

# Get duplicate points by iterating over first half of string 
# and checing if any characters appear at least once in second half
function get_dupe_points(contents::String)
    total::UInt32 = 0
    half::UInt32 = length(contents)/2
    seen = Set{Char}()
    for i in 1:half
        # If in and not yet seen
        if occursin(contents[i], contents[half + 1:end]) && !(contents[i] in seen)
            total += point_dict[contents[i]]
            push!(seen, contents[i])
        end
    end
    return total
end

# Helper function to get all values of one container that exist in other
function get_dupe_items(container_1::Union{Set{Char}, String}, container_2::Union{Set{Char}, String})
    seen = Set{Char}()
    for item in container_1
        if item in container_2
            push!(seen, item)
        end
    end
    return seen
end

# Iterate over all sets of 3 elves and find common items
function count_badges(contents)
    total::UInt32 = 0
    # Indices in strides of 3
    indices = collect(1:3:length(contents))

    for i in indices
        seen_1 = get_dupe_items(contents[i], contents[i+1])
        badge = collect(get_dupe_items(seen_1, contents[i+2]))
        total += point_dict[badge[1]]
    end
    return total
end

println("The solution to part one is: ", sum(get_dupe_points.(all_contents)))
println("The solution to part two is: ", count_badges(all_contents))

