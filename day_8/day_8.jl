
in_file = "input/input_8.txt"

# Read in input file as an array of strings
🌲🌲🌲  = open(in_file) do file
    readlines(file)
end

# Turn Vector of Strings into Matrix of Ints
function parse_forest(🌲::Vector{String})::Matrix{Int}
    # First turn strings into vectors with collect
    # Then turn vector of vectors into matrix with reduce and hcat
    # Then parse into ints 
    🗺️ = x -> collect.(x) |> x -> reduce(hcat, x) |> x -> parse.(Int, x)
    return 🗺️(🌲)
end


translate_directions = Dict([("top", ([0 1; 1 0], 1:1:99)), ("bottom", ([0 1; 1 0], 99:-1:1)),
                             ("left", ([1 0; 0 1], 1:1:99)), ("right", ([1 0; 0 1], 99:-1:1))])


                             
function traverse_forest(forest, direction, container, index)
    translation, traversal = translate_directions[direction]



    largest_so_far = -1
    for j in traversal
        x, y = translation*[index, j]

        if forest[x,y] > largest_so_far
            container[x,y] = 1
            largest_so_far = forest[x,y]
        end

        # Terminate after a tree of size 9 is reached
        if largest_so_far == 9
            break
        end
    end

    return container
end


function get_view_dist(forest, direction, container, index)
    translation, traversal = translate_directions[direction]


    for j in traversal
        x, y = translation*[index, j]
        viewing_height = forest[x,y]
        seen = 0
        for seeker in min(j + traversal.step,99):traversal.step:traversal.stop
            seen += 1

            x_seek, y_seek = translation*[index, seeker]

            if forest[x_seek, y_seek] >= viewing_height
                break
            end

        end

        container[x, y] = seen
    end

    return container
end


function get_unseen_trees(forest)
    # Define visibility arrays for each direction
    visible_left = zeros(Int, size(forest))
    visible_right = zeros(Int, size(forest))
    visible_top = zeros(Int, size(forest))
    visible_bottom = zeros(Int, size(forest))


    Threads.@threads for i = 1:99
        traverse_forest(forest, "left", visible_left, i)
        traverse_forest(forest, "right", visible_right, i)
        traverse_forest(forest, "top", visible_top, i)
        traverse_forest(forest, "bottom", visible_bottom, i)
    end

    #visible_left
    comb = visible_left + visible_right + visible_bottom + visible_top
    return comb .> 0
end

function get_best_view(forest)
    # Define visibility arrays for each direction
    visible_left = zeros(Int, size(forest))
    visible_right = zeros(Int, size(forest))
    visible_top = zeros(Int, size(forest))
    visible_bottom = zeros(Int, size(forest))


    Threads.@threads for i = 1:99
        get_view_dist(forest, "left", visible_left, i)
        get_view_dist(forest, "right", visible_right, i)
        get_view_dist(forest, "top", visible_top, i)
        get_view_dist(forest, "bottom", visible_bottom, i)
    end
    #visible_left
    comb = visible_left .* visible_right .* visible_bottom .* visible_top
    return comb 
end

forest = parse_forest(🌲🌲🌲)


println("The solution to part one is: ", sum(get_unseen_trees(forest)))
println("The solution to part two is: ", maximum(get_best_view(forest)))
