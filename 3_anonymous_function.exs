# Anonymous functions must be called with . and (), otherwise "undefined function sum/2"
sum = fn a, b -> a + b end
IO.puts(sum.(2, 3))

# A function without parameters
hello_world = fn -> IO.puts("Hello world") end
hello_world.()

# List concat
list_concat = fn l1, l2 -> l1 ++ l2 end
list_concat.([:a, :b], [:c, :d])

# Sum three values
sum_2 = fn a, b, c -> sum.(sum.(a, b), c) end
IO.puts(sum_2.(1, 2, 3))

# Tuple to list
pair_tuple_to_list = fn {a, b} -> [a, b] end
pair_tuple_to_list.({1234, 5678})
