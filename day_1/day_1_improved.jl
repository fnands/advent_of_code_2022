using TimerOutputs
const to = TimerOutput()

in_file = "input/input_1.txt"



function get_max_calories(in_file::String)::UInt32

    # Read in input file as a string
    calories = open(in_file) do file
        read(file, String)
    end

    # Max elf calorie storage
    max_elf_calories::UInt32 = 0

    # Initialize current elf calorie counter
    this_elf_calories::UInt32 = 0

    # Use eachsplit to group total calories by elf
    for elf = eachsplit(calories, "\n\n")
        # Use eachsplit to split elf calories by delimiter, 
        # then broadcast parse to int and sum
        this_elf_calories = sum(parse.(UInt32, eachsplit(elf)))
        # Find max
        max_elf_calories = max(this_elf_calories, max_elf_calories)
    end

    return max_elf_calories

end


function get_sum_top_k_calories(in_file::String, k::Int=3)::UInt32

    # Read in input file as a string
    calories = open(in_file) do file
        @timeit to "read" read(file, String)
    end

    @timeit to "main_logic" begin

        # Top k elf calorie storage
        max_elf_calories = zeros(UInt32, k)
        # Initialize current elf calorie counter
        this_elf_calories::UInt32 = 0

        # Use eachsplit to group total calories by elf
        for elf = eachsplit(calories, "\n\n")
            # Use eachsplit to split elf calories by delimiter, 
            # then broadcast parse to int and sum
            this_elf_calories = sum(parse.(UInt32, eachsplit(elf)))
            # Find max
            max_elf_calories[1] = max(this_elf_calories, max_elf_calories[1])

            # Sort max elf calories
            @timeit to "sort" sort!(max_elf_calories)
        end
    end
    return sum(max_elf_calories)

end

println("The solution to part one is: ", get_max_calories(in_file))

println("The solution to part one is: ", get_sum_top_k_calories(in_file, 3))

function time_function(timed_function::Function, input, times::Int, name)
    for _ in 1:times
        @timeit to name timed_function(input)
    end
end

time_function(get_max_calories, in_file, 1000, "case_1")

time_function(get_sum_top_k_calories, in_file, 1000, "case_2")

print_timer(to::TimerOutput)