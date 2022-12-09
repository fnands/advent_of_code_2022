using DataStructures

in_file = "day_7/input_7.txt"

# Read in input file as an array of strings
💾  = open(in_file) do file
    readlines(file)
end






function parse_directories(💾)

    stack = Stack{Int}()
    sum_of_small = 0
    max_size = 100000
    current_count = 0

    all_dirs = Vector{Int}()
    total::Int = 0

    for line in 💾

        line_array = split(line, " ")
        value = tryparse(Int, line_array[1])
        
        # If this line contains size info, add it
        if value !== nothing
            current_count += value
        end

    
        # If stepping into dir, push current count to stack and set counter to 0
        if line_array[2] == "cd" && line_array[3] != ".."
            push!(stack, current_count)
            current_count = 0
        end
    
        # If stepping back, pop off stack and add to total
        if line == "\$ cd .."
            if current_count <= max_size
                sum_of_small += current_count
            end
            # Add directory size to collection of sizes
            push!(all_dirs, current_count)
            # Add back previous level count to current count
            current_count += pop!(stack)
            
        end

    end

    # get back to base dir and add last ones to count
    while length(stack) != 0
        push!(all_dirs, current_count)
        current_count += pop!(stack)
    end
    return sum_of_small, all_dirs
end

function calc_smallest(dir_list::Vector{Int})
    # Calculate free space on device
    free_space = (70000000 - all_dirs[end])
    # Get the minimum size to be freed to get to 30MB
    min_size = 30000000 - free_space
    # Initialize min value variable to max size of device 
    max_min = 70000000
    
    # Iterate through all folders sizes to find smallest dir that satisfies criteria
    for size in all_dirs
        if size >= min_size && size < max_min
            max_min = size
        end
    end
    return max_min
end

sum_of_small, all_dirs = parse_directories(💾)
to_be_freed = calc_smallest(all_dirs)

println("The solution to part one is: ", sum_of_small)
println("The solution to part two is: ", to_be_freed)
