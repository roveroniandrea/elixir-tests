# Guards can be used to add other conditions after pattern matching
defmodule Guard do
  # WHEN clause is evaluated after pattern matching
  def what_is(x) when is_number(x) do
    IO.puts("x is a number #{x}")
  end

  # If when does not succeed, the match continues
  def what_is(x) when is_list(x) do
    IO.puts("x is a list #{inspect(x)}")
  end

  def what_is(_) do
    IO.puts("x is something else")
  end
end

Guard.what_is(3)
Guard.what_is([3, 4, 5])
Guard.what_is({:value, 9})

# Revriting the Factorial in order to guard for negative numbers
defmodule Factorial do
  def factorial(0), do: 1
  def factorial(n) when is_integer(n) and n > 0, do: n * factorial(n - 1)
end

# Decomment the following lines to throw an error
# IO.puts(Factorial.factorial(-1))
# IO.puts(Factorial.factorial(["This is a list!"]))

# We could also raise an exception using a normal if statement, but guards should be preferred because are more explicit
defmodule AssertModule do
  def assertAtom(atom) when is_atom(atom) do
  end

  def assertAtom(atom) do
    if not is_atom(atom) do
      raise "Not an atom"
    end
  end
end

# Decomment to test
# AssertModule.assertAtom("This is a string!")

# This is equivalent but using an anonymous function
assert_atom = fn
  atom when is_atom(atom) ->
    true

  atom ->
    if not is_atom(atom) do
      raise "Not an atom"
    end

    true
end

# Decomment to test
# assert_atom.(["This is a list!"])

# Note that not everything can be called inside a WHEN clause.
# As the error says:
# Only macros can be invoked in a guards and they must be defined before their invocation.
not_a_macro = fn -> nil end

defmodule NotAMacroModule do
  # Will throw the following error:
  # invalid expression in guards, anonymous call is not allowed in guards.
  def test when not_a_macro.() do
    IO.puts("This will never match")
  end
end

# Decomment to test
NotAMacroModule.test()
