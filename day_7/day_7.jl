using DataStructures

in_file = "day_7/input_7.txt"

# Read in input file as an array of strings
💾  = open(in_file) do file
    readlines(file)
end






function parse_directories(💾)

    queue = Stack{Int}()
    dirs = Stack{String}()
    sum_of_small = 0
    max_size = 100000
    current_count = 0

    for line in 💾


        line_array = split(line, " ")
        value = tryparse(Int, line_array[1])
        

    
        # If user goes back, pop off stack and add to total
        #if line == "\$ ls"
        if line_array[2] == "cd" && line_array[3] != ".."
            #print(line_array)
            push!(queue, current_count)
            push!(dirs, line_array[3])
            current_count = 0
            #println("forward")
        end
    
        # If user goes back, pop off stack and add to total
        if line == "\$ cd .."
            println(dirs)
            if current_count <= max_size
                sum_of_small += current_count
            end
            current_count += pop!(queue)
            pop!(dirs)
        end

        if value !== nothing
            current_count += value
        end


    end
    return sum_of_small
end

parse_directories(💾)

#println(split("\$ cd ..", " ")[3] != "..")
