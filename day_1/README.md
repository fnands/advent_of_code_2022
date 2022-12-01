# Day 1

## Key Lessons

* A few people on reddit used `eachsplit`. 
    * `eachsplit` will iterate over a string based on some delimeter, so easy way to iterate over each elf, which is delimeted by newline.
    * I included it in the "improved" version, but it is about 50% slower than what I did and uses almost 2x as much memory
    * The way I initially did it, the string was parsed to an array, which is slower than just reading to a string, but once that's done looping over the array is faster than using `eachsplit`
* Should just use `max` (like python) for max checks
* `.` is the broadcast operator, so `parse.(UInt32, eachsplit(elf)` will parse every item in the iterator returned by `eachsplit`
* `TimerOutputs` is useful for benchmarking performance