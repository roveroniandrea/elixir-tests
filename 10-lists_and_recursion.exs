# Lists can be iterated recursively by splitting head (single element) and tail (another list, even empty)
defmodule ListLength do
  def length([]), do: 0
  # Note: I had to prefix ListLength.length/1 because it conflicted with Kernel.length/1
  def length([_head | tail]), do: 1 + ListLength.length(tail)
end

IO.puts(ListLength.length([1, 2, 3, 4]))

# List can also be built in this way
defmodule SquareList do
  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]
end

IO.inspect(SquareList.square([1, 2, 3, 4, 5]))

# Reducing a list
defmodule ReduceList do
  def reduce([], _func, initialAcc), do: initialAcc
  def reduce([head | tail], func, initialAcc), do: reduce(tail, func, func.(initialAcc, head))
end

IO.puts(
  # We could also pass the function as &(&1 + &2) but come on!
  "Sum of a list is: #{ReduceList.reduce([1, 2, 3, 4, 5], fn acc, value -> acc + value end, 0)}"
)

# Exercise
# Write a funtion that returns the max element in a list
defmodule MaxList do
  def max_list(l), do: max_list(l, nil)

  defp max_list([], curr_max), do: curr_max

  # Note: some_number > nil is always false
  defp max_list([head | tail], curr_max) when is_nil(curr_max) or head > curr_max,
    do: max_list(tail, head)

  defp max_list([_head | tail], curr_max), do: max_list(tail, curr_max)
end

IO.puts(MaxList.max_list([10, 20, 25, 10, 5]))

# Write a function that adds n to each letter of a string
# (single quoted string, so that it's considered as a list of ASCII integer characters)
# wrapping if the result is greter that z
defmodule Caesar do
  def caesar([], _n), do: []
  # In this match, we can safely add n to head and be sure to not go above 'z'
  def caesar([head | tail], n) when head + n < 123, do: [head + n | caesar(tail, n)]
  # Otherwise we need to wrap
  def caesar([head | tail], n), do: [rem(head + n, 123) + 97 | caesar(tail, n)]
end

# ~c is knows as a `sigil`. The ~c sygil converts a string into a list of ASCII integers
# Moreover, IO.puts will convert the ASCII list to the corresponding string
IO.puts(Caesar.caesar(~c"ryvkve", 13))

# Exercise
# Write a function MyList.span(from, to) that returns a list of the numbers in from..to range
defmodule MyList do
  def span(to, to), do: [to]
  def span(from, to), do: [from | span(from + 1, to)]
end

IO.inspect(MyList.span(10, 20))

# The List module contains some funtions to operate on lists
IO.puts("List concatenation: #{inspect([1, 2] ++ [3, 4])}")
IO.puts("List flatten: #{inspect(List.flatten([1, [[2, 3], [[4]]], [5]]))}")

# Like reduce, but can choose the direction
IO.puts("fodl: #{inspect(List.foldl([1, 2, 3, 4], ~c"", &"#{&1} comes after (#{&2})"))}")
IO.puts("fodr: #{inspect(List.foldr([1, 2, 3, 4], ~c"", &"#{&1} comes after (#{&2})"))}")

# Replacing an element at an index with another (not cheap operation, I think because it needs to iterate through the list)
IO.puts("Replace: #{inspect(List.replace_at([1, 2, 3], 1, :hola))}")

# There are some more that operates on list consistng of tuples, like `List.keyfind`, `List.keydelete`, `List.keyreplace`
