# Named functions can also have default parameters
defmodule DefaultParams do
  def my_function(a \\ 2), do: a
end

# Prints 2
IO.puts(DefaultParams.my_function())
# Prints 3
IO.puts(DefaultParams.my_function(3))

# But not unnamed functions!
# Raises "anonymous functions cannot have optional arguments"
# Decomment to test
# unnamed_func = fn a \\ 2 -> a end

# Giving values to default parameters is a bit weird
defmodule WeirdParams do
  def weird_default_parameters(a, b \\ 2, c \\ 3, d), do: [a, b, c, d]
end

# Prints ["a", 2, 3, "b"]. This can make sense I suppose
IO.puts(WeirdParams.weird_default_parameters("a", "b"))

# Insufficient required parameters raises error. Still makes sense
# IO.puts(WeirdParams.weird_default_parameters("a"))

# Prints ["a", "b", "c", "d"]. This is good
IO.puts(WeirdParams.weird_default_parameters("a", "b", "c", "d"))

# Prints ["a", "b", 3, "c"]. EXCUSE ME WHAT THE F
# The way it works (I suppose) is that it says "ok there are more than two required parameters,
# so first 2 can override two params
# but the third one must pass its value to the fourth variable"
# So it does not work by first overriding default parameters, hoping that arguments will be enough, but instead checks it before
IO.puts(WeirdParams.weird_default_parameters("a", "b", "c"))

# Excercise: guessing a number using dicotomic search in a range
defmodule GuessGame do
  def guess(value, lower_range..upper_range)
      when lower_range == value or upper_range == value do
    IO.puts("It's #{value}!")
    value
  end

  def guess(value, lower_range..upper_range) do
    # div(lower_range, upper_range) could also be used to perform integer division
    mid = floor((lower_range + upper_range) / 2)
    IO.puts("Range is #{lower_range}..#{upper_range}. Is it #{mid}?")

    if(mid > value) do
      guess(value, lower_range..(mid - 1))
    else
      guess(value, mid..upper_range)
    end
  end
end

IO.puts(GuessGame.guess(273, 1..1000))

# Private functions are possible with `defp` keywork
defmodule PrivateFunctions do
  defp private(x), do: x
  def public(x), do: private(x)
end

IO.puts(PrivateFunctions.public(2))
# This fails with error "function PrivateFunctions.private/1 is undefined or private"
# IO.puts(PrivateFunctions.private(2))
