# Things need to implement the `Enumerable` protocol in order to be iterated

# The `Enum` module allows to iterate, filter, combine and generally manipulate collections

# Converting something into a list
IO.puts("From range to list: #{inspect(Enum.to_list(1..5))}")

# Concatenationg collections
IO.puts("List and range concatenated: #{inspect(Enum.concat([1, 2, 3, 4], 5..10))}")

# Remapping a collection
IO.puts("Squared 1..10: #{inspect(Enum.map(1..10, &(&1 * &1)))}")

# Picking an index
IO.puts("Index 3 in 1..10: #{Enum.at(1..10, 3)}")

# Filtering
IO.puts("Even numbers: #{inspect(Enum.filter(1..10, &(rem(&1, 2) == 0)))}")
# (also available in the reverse filter, reject)
IO.puts("Odd numbers: #{inspect(Enum.reject(1..10, &(rem(&1, 2) == 0)))}")

# Sorting
IO.puts("Sorted: #{inspect(Enum.sort(["Lorem", "ipsum", "dolor", "sit", "amet"]))}")

# Extracting max
IO.puts("Max value: #{Enum.max(1..10)}")

# Join
IO.puts("Joined: #{inspect(Enum.join(1..10, " --> "))}")

# Predicates like `.all`, `.any`, `.empty`

# Merging two lists A and B, nth element of A with nth element of B
IO.inspect(Enum.zip([1, 2, 3], [:a, :b, :c]))

# Reduce
# NOTE: Element and accumulator are swapped respect to JS!
IO.puts(
  "Longest string: #{Enum.reduce(["Lorem", "ipsum", "dolor", "sit", "amet"], fn str, acc -> if String.length(str) > String.length(acc) do
      str
    else
      acc
    end end)}"
)

# Excercises
# Implement flatten
my_list = [1, [2, 3, [4]], [5], [[[6]]]]

defmodule MyFlatten do
  def flatten([]), do: []
  # If the head is a list itself, flatten and concatenate recursively
  def flatten([head = [_head | _tail] | tail]), do: flatten(head) ++ flatten(tail)
  # If head is not a list (previous match did not succeed), just flatten the tail
  def flatten([head | tail]), do: [head | flatten(tail)]
end

IO.puts(
  "Flattened by library: #{inspect(List.flatten(my_list))}\nFlattened by same implementation: #{inspect(MyFlatten.flatten(my_list))}"
)
