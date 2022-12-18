in_file = "input/input_10.txt"

# Read in input file as an array of strings
📶 = open(in_file) do file
    readlines(file)
end


function add_if_in(cycle, list, value)    
    if cycle in list
        return value*cycle
    else
        return 0
    end
end

function draw_pixel(cycle, value)
    if cycle%40 >= value - 1 && cycle%40  <= value + 1
        #println(cycle%40, " ", value)
        print("#")
    else
        print(".")
    end
    
    if (cycle + 1)%40 == 0
        print("\n")
    end
end

function parse_instructions(instr)

    current = 1
    total = 0
    i = 1
    breaks = [20, 60, 100, 140, 180, 220]

    for signal in instr
        
        draw_pixel(i -1, current )
        line_array = split(signal, " ")
        
        i += 1
        total += add_if_in(i, breaks, current)
        
        # If this line contains size info, add it
        if length(line_array) > 1
            #println(line_array[2])
            draw_pixel(i -1, current)
            i += 1
            

            current += parse(Int, line_array[2])
            total += add_if_in(i, breaks, current)
            
    
        end
    
        
    
    end
    return total
end

parse_instructions(📶)
