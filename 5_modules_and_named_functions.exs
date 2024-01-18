# Modules wrap and organize named functions
# Named function must be written inside a module
defmodule Times do
  # The number of parameters in a function is called its "arity"
  def double(n) do
    n * 2
  end

  # The above definition is a syntactic sugar for the following
  # This can be used for one-line functions, but it's also how Elixir compiles a function, removing the syntactic sugar
  # More precisely, each do ... end block can be written as
  # , (do:          # Notice the trailing comma
  # instruction1
  # instruction2
  # )
  def double_2(n), do: n * 2

  # Functions in the same module might not be prefixed by module name
  def quadruple(n), do: double(n) + Times.double(n)
end

IO.puts(Times.double(4))

# Each function is uniquely identified by its name and its arity
# Function name will be `Times.double/1`
# Decomment in order to crash the execution and print the function name
# IO.puts(Times.double("This will crash and print 'Times.double/1' on the stack trace"))

IO.puts(Times.quadruple(4))

defmodule Factorial do
  # Two functions with same name and arity are just multiple implementation of the same function
  def factorial(0), do: 1
  def factorial(n), do: n * factorial(n - 1)
end

IO.puts(Factorial.factorial(4))

defmodule Fibonacci do
  def fibo(0), do: 0
  def fibo(1), do: 1
  def fibo(n), do: fibo(n - 1) + fibo(n - 2)
end

IO.puts(Fibonacci.fibo(6))

defmodule ListLength do
  def len([]), do: 0
  # This matches a one-length list because tail will be empty list
  def len([_ | tail]), do: 1 + len(tail)
end

IO.puts(ListLength.len([1, 2, 3, 4, 5]))
