# Control flow is less used in Elixir, but still important
# A combination of pattern matching and guard clauses replaces if statements

# If statement can have do and else specified in a similar way to keyword list (notice the semi between them and colons after the property)
result_1 = if String.length("Hola mundo") > 0, do: "This is true", else: "This is false"
IO.puts(result_1)

# It might also be declared with the same syntactic sugar as function bodies:
result_2 =
  if String.length("Hi world") do
    "This is true"
  else
    "This is false"
  end

IO.puts(result_2)

# The evil twin of if is `unless`
# Unless is a negated if
result_3 = unless String.length("Hola mundo") > 0, do: "This is true", else: "This is false"
IO.puts(result_3)

# The `cond` macro allows to specify multiple conditions. Only the first truthy found is executed
result_4 =
  cond do
    String.length("Bonjour le monde") > 0 -> "String is not empty"
    String.length("Bonjour le monde") == 0 -> "String is empty"
    # A default case can be handled by using an always truthy condition
    true -> "String has negative length??"
  end

IO.puts(result_4)

# Case is similar to cond, but allows to test a value against multiple patterns.
# Only the first matched pattern is executed, unlike JS
result_5 =
  case String.length("Hej världen") do
    n when is_integer(n) and n > 0 -> "String is not empty"
    0 -> "String is empty"
    # Default match
    _ -> "String has negative length??"
  end

IO.puts(result_5)

#
# Exceptions
# NOTE: Exceptions are not conrol flows and should not be used like that
# They should be used when something unexpected happens

# Decomment to try
# raise "Gonna give you up!"

# Optionally it can be specified the type of the exception and a message
# raise RuntimeError, message: "Gonna let you down!"

# In Elixir convention, functions that might raise errors end with a !
_ = File.open("This will not rise an error, unless pattern matching fails.txt")
_ = File.open!("This will rise an error.txt")
