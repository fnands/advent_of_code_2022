
in_file = "day_5/input_5.txt"

# Read in input file as an array of strings
🟩🟥🟨  = open(in_file) do file
    readlines(file)
end

# Turn Vector of Strings into Vector of Vector of Chars
function parse_stack(🟨::Vector{String})::Vector{Vector{Char}}
    # First turn strings into vectors with collect
    # Then turn vector of vectors into matrix with reduce and hcat
    # Then select only relevant with getindex 
    📦 = x -> collect.(x) |> x -> reduce(hcat, x) |> x -> getindex(x, 2:4:34, :)
    return eachrow(📦(🟨)) .|> x -> filter(n -> n != ' ', x)
end


# Turn String into Vector of Ints
function parse_commands(🦿::String)::Vector{Int}
    🦾 = x -> split.(x, " ") |> x -> getindex(x, 2:2:6) |> x -> parse.(Int, x)
    return 🦾(🦿)
end

function move_stack(current_stack::Vector{Vector{Char}}, instructions::Vector{Int}, mover::Int)
    amount = instructions[1]
    from_stack = instructions[2]
    to_stack = instructions[3]

    if mover == 9000
        taken = current_stack[from_stack][1:amount] |> reverse
    elseif mover == 9001
        taken = current_stack[from_stack][1:amount] 
    end

    left = current_stack[from_stack][amount + 1:end]


    # Concatenate
    current_stack[to_stack] = vcat(taken, current_stack[to_stack])
    current_stack[from_stack] = left
    return current_stack
end


function shuffle_stacks(starting_stack::Vector{Vector{Char}}, instructions::Vector{Vector{Int}}, mover::Int)
    # Copy so we don't mix up original stack
    stack = copy(starting_stack)
    for command in instructions
        stack = move_stack(stack, command, mover)
    end
    return stack
end 
starting_stack = parse_stack(🟩🟥🟨[1:8])


commands = parse_commands.(🟩🟥🟨[11:end])



shuffle_stacks(starting_stack, commands, 9000)
shuffle_stacks(starting_stack, commands, 9001)