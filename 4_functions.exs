# A function can have multiple bodies (but the must all have the same number of parameters)
# The first body that matches is invoked
handle_open = fn
  {:ok, file} ->
    "File opened"

  # :file atom refers to Erlang File module
  {_, error} ->
    "Error: #{:file.format_error(error)}"
    # Also note string interpolation via #{}
end

# While File variable refers to Elixir File module
IO.puts(handle_open.(File.open("4_multiple_bodies.exs")))
IO.puts(handle_open.(File.open("4_multiple_bodies.exs______")))

# Not a fizzbuzz
not_a_fizzbuzz = fn
  # Return FizzBuzz if first two params are 0
  0, 0, _ -> "FizzBuzz"
  # Return Fizz if first param is 0
  0, _, _ -> "Fizz"
  # Return Buzz if second param is 0
  _, 0, _ -> "Buzz"
  # Otherwise return third param
  _, _, c -> c
end

IO.puts(not_a_fizzbuzz.(0, 0, :hola))
IO.puts(not_a_fizzbuzz.(0, 12, :hola))
IO.puts(not_a_fizzbuzz.(13, 0, :hola))
IO.puts(not_a_fizzbuzz.(13, 14, :hola))

# Wait, this is a FizzBuzz without conditional logic!
this_is_fizzbuz = fn n -> not_a_fizzbuzz.(rem(n, 3), rem(n, 5), n) end
IO.puts(this_is_fizzbuz.(10))
IO.puts(this_is_fizzbuz.(11))
IO.puts(this_is_fizzbuz.(12))
IO.puts(this_is_fizzbuz.(13))
IO.puts(this_is_fizzbuz.(14))
IO.puts(this_is_fizzbuz.(15))
IO.puts(this_is_fizzbuz.(16))

# Closures
greet = fn name -> fn -> IO.puts("Hello #{name}") end end
greet_silvia = greet.("Silvia")
greet_andrea = greet.("Andrea")

greet_silvia.()
greet_andrea.()

prefix = fn pref -> fn suff -> "#{pref} #{suff}" end end
darth = prefix.("Darth")
IO.puts(darth.("Vader"))
IO.puts(darth.("Sidious"))

# Pass functions as value
apply_func = fn func, value -> func.(value) end
IO.puts(apply_func.(darth, "Maul"))

# Enum.map function
doubled_list = Enum.map([1, 2, 3], fn el -> el * 2 end)
# Inspect allows to print a list
IO.inspect(doubled_list)

# The & notation
# & converts what follows in an anonymous function. &1, &2... &n refers to the ordered params
greetings_2 = &IO.puts("Hello #{&1}")
greetings_2.("Mum")

# & also works with list, tuple, literals
notationAnd_1 = &"Hello #{&1}"
notationAnd_2 = &{:key1, &1}
IO.puts(notationAnd_1.("Luna"))
notationAnd_2.("Value1")

# Some revrites using &
# sum_2 = &Enum.map(&1, &(&1 + 2)) # Nested captures are not allowed
sum_2 = &Enum.map(&1, fn el -> el + 2 end)
IO.inspect(sum_2.([1, 2, 3, 4]))
