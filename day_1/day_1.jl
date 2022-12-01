using TimerOutputs
const to = TimerOutput()

in_file = "day_1/input_1.txt"





function get_max_calories(in_file::String)::UInt32

    # Read in input file as an array of strings
    calories = open(in_file) do file
        readlines(file)
    end

    # Max elf calorie storage
    max_elf_calories::UInt32 = 0

    # Initialize current elf calorie counter
    this_elf_calories::UInt32 = 0

    # Iterate through list of calories
    for item in calories
        if item == ""
            # If this elf is carrying more than max, set it to max
            if this_elf_calories > max_elf_calories
                max_elf_calories = this_elf_calories
            end

            # Reset counter
            this_elf_calories = 0
        else
            this_elf_calories += parse(UInt32, item)
        end
    end

    return max_elf_calories

end


function get_sum_top_k_calories(in_file::String, k::Int=3)::UInt32

    # Read in input file as an array of strings
    calories = open(in_file) do file
        @timeit to "readlines" readlines(file)
    end

    @timeit to "main_logic" begin

        # Top k elf calorie storage
        max_elf_calories = zeros(UInt32, k)

        # Initialize current elf calorie counter
        this_elf_calories::UInt32 = 0

        # Iterate through list of calories
        for item in calories
            if item == ""
                # If this elf is carrying more than the smallest value in the max 
                # array, set it to max
                if this_elf_calories > max_elf_calories[1]
                    max_elf_calories[1] = this_elf_calories
                end

                # Reset counter
                this_elf_calories = 0

                # Sort max elf calories
                @timeit to "sort" sort!(max_elf_calories)
            else
                this_elf_calories += parse(UInt32, item)
            end
        end
    end

    return sum(max_elf_calories)

end

println("The solution to part one is: ", get_max_calories(in_file))

println("The solution to part one is: ", get_sum_top_k_calories(in_file,3))

function time_function(timed_function::Function, input, times::Int, name)
    for _ in 1:times
        @timeit to name timed_function(input)
    end
end

time_function(get_max_calories, in_file, 1000, "case_1")

time_function(get_sum_top_k_calories, in_file, 1000, "case_2")

print_timer(to::TimerOutput)