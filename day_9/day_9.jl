
in_file = "input/input_9.txt"

# Read in input file as an array of strings
head_moves  = open(in_file) do file
    readlines(file)
end


translate_directions = Dict([("U", ([0 1; 1 0])), ("D", ([0 -1; -1 0])),
                             ("L", ([-1 0; 0 -1])), ("R", ([1 0; 0 1]))])

function distance(head_pos, tail_pos)
    diff = head_pos - tail_pos
    abs_diff = abs.(diff)
    dist = max(abs_diff[1], abs_diff[2])
    if dist > 1
        return sign.(diff)
    else
        return [0, 0]
    end
end

function follow_instructions(head_moves, translate_directions, body_len = 10)
    visited = Set([[0, 0]])


    ropes = [zeros(2) for _ in 1:body_len]

    for move in head_moves
        direction = split(move) |> x -> getindex(x, 1)
        amount = split(move) |> x -> getindex(x, 2) |> x -> parse(Int, x)

        step = translate_directions[direction]*[1, 0]
        for _ in 1:amount
            ropes[1] += step
            for knot in 2:body_len
                tail_move = distance(ropes[knot - 1], ropes[knot])
                ropes[knot] += tail_move
            end
            
            push!(visited, ropes[body_len])
            
        end
    
    end
    return visited
end


println("The solution to part one is: ", length(follow_instructions(head_moves, translate_directions, 2)))
println("The solution to part two is: ", length(follow_instructions(head_moves, translate_directions, 10)))

