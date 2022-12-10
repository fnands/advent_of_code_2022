# Day 8

## Key Lessons
* I wanted to try out multi-threading in Julia and this seemed like a good problem to try. 
    * I did not play around with locks/semaphores as code will never write to same memory in parallel.
    * Can easily multithread a for loop with `Threads.@threads for i = 1:99`
    * No need to do anything more than just that, rather simple. 
* `A * B` will give you the dot product between matrix `A` and `B`, but `A .* B` will give you the element-wise multiplication of matrices. 