# Day 3

## Key Lessons
* The `=>` operator creates a pair structure, so `a => b` will yield `Pair(a, b)`
* It can be used to create a dict from a list of keys `x` and a list of values `y` as `Dict(x .=> y)` syntax 
* `collect` is an easy way to turn a range (or iterator) into an array, i.e.
    * `collect(1:52)` will yield an array from 1 to 52 of type Int
* Can use `occursin(object container)` or `object in container` to check if a `Char` is in a `String`. Is one better than the other? 
* `push!` appends to a container in-place 