defmodule MathModule do
  def double(val), do: val * 2
  def powerOfTwo(val), do: val * val
  def multiply(a, b), do: a * b
end

# Suppose that we have some intermediate values that we need to pass to the next function
# Gives 3 * 2 = 6
intermediate_1 = MathModule.double(3)
# Gives 6^2 = 36
intermediate_2 = MathModule.powerOfTwo(intermediate_1)
# Gives 36 * 5 = 180
final_result = MathModule.multiply(intermediate_2, 5)
IO.puts(final_result)

# We could prevent using intermediate values, preferring the pipe operator
print_function = &IO.puts("This is the same as before: #{&1}")

MathModule.double(3)
# The pipe operator valorizes the first parameter of the next function
|> MathModule.powerOfTwo()
# So in this case, only the second parameter is specified
|> MathModule.multiply(5)
# We can also use anomymous functions, but it seems that directly defining here does not work
|> print_function.()
