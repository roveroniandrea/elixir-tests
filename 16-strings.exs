# Elixir has two types of stings: single and double quoted
# They differ in their internal representation

# The both support interpolation of expression and character escaping
str_a = "Double quoted #{12} \"string\""

# My formatted prepends that sigil in front of single quoted strings
str_b = ~c"Single quoted #{12} 'string'"

# Both can be multiline, and spaces and tabs are preseved by default
IO.puts("
Multiline
  string
")

# Except when using Heredocs, which does not preserve spacing
# In order for this to happen, the ending """ should be indented the same level as
# (Well, my formatter keeps removing any indentation)
IO.puts("""
Multiline
string
with heredoc
""")

# Heredocs are used to add documentations to functions and modules
# Hovewer it seems that VS Code extension does not support it when hovering
defmodule DocModule do
  @moduledoc """
  This module is documented by using the @moduledoc attribute (remeber that @ are module attributes)
  Note that this is added inside the module
  """

  @doc """
    Function documentation is instead added in top of the function
  """
  def docFunction, do: nil
end

#
# Something about sigils...
#

# NOTE:
# Single quoted strings are, more specifically, called "character lists" in the Elixir convertion (because that's what they are)
# So, libraries that work on "strings" only work on double quoted ones

# Character lists are represented as lists of integer values
# Also, pattern matching works like on normal lists
defmodule ReverseSingleQuotedString do
  def reverse(character_list)

  def reverse(~c""), do: ~c""
  def reverse([head | tail]), do: reverse(tail) ++ [head]
end

IO.puts(ReverseSingleQuotedString.reverse(~c"Hello world"))

# Excercises
# Write an anagram?(word1, word2) that returns true if its parameters are anagrams
defmodule AnagramModule do
  def anagram?(word1, word2)
  def anagram?(~c"", ~c""), do: true

  # Two words are anagram if the first character of one is present on the second word, and remaining words are still anagram
  def anagram?([head1 | tail], word2), do: anagram?(tail, remove_char(head1, word2))
  def anagram?(_, _), do: false

  # Utility functions to remove a character from a character list
  # The return nil, or a string with an ending nil value, if the character is not present
  defp remove_char(char, list)
  defp remove_char(char, [char | tail]), do: tail
  defp remove_char(char, [head | tail]), do: [head | remove_char(char, tail)]
  defp remove_char(_, _), do: nil
end

IO.puts(AnagramModule.anagram?(~c"Ciao", ~c"oaiC"))
IO.puts(AnagramModule.anagram?(~c"heLlo", ~c"oehLl"))
IO.puts(AnagramModule.anagram?(~c"heLlo", ~c"oehLlo"))
IO.puts(AnagramModule.anagram?(~c"heLlo", ~c"oeh"))
IO.puts(AnagramModule.anagram?(~c"Hello", ~c"Hello"))

# Write a function that accepts a character list of a stringified operation in the form
# number[+-*/]number and returns the result of the calculation. Numbers are always positive

defmodule Calculator do
  def calculate(operation) do
    result = split_operands(operation)
    IO.inspect(result)
    operand1 = parse(result[:operand1])
    operand2 = parse(result[:operand2])

    case result[:operation] do
      :SUM -> operand1 + operand2
      :SUB -> operand1 - operand2
      :MUL -> operand1 * operand2
      :DIV -> operand1 / operand2
    end
  end

  # Detect operation and second operand
  # NOTE that the ? operator is used to return the integer code of a character
  # Doing something like defp split_operands(['c' | tail]) won't work because that character will match a single element list
  defp split_operands([?+ | tail]), do: %{operand1: nil, operation: :SUM, operand2: tail}
  defp split_operands([?- | tail]), do: %{operand1: nil, operation: :SUB, operand2: tail}
  defp split_operands([?* | tail]), do: %{operand1: nil, operation: :MUL, operand2: tail}
  defp split_operands([?/ | tail]), do: %{operand1: nil, operation: :DIV, operand2: tail}

  # Detect first operand
  defp split_operands([head | tail]) do
    result = split_operands(tail)
    Map.merge(result, %{operand1: [head | result[:operand1] || []]})
  end

  # Parsing a character list to integer
  defp parse([]), do: 0

  defp parse([head | tail]) do
    parsed_tail = parse(tail)

    # Remove 48 for ASCII encoding, then multiply by 10, 100 or more depending on number of characters in the tail
    (head - 48) * 10 ** length(tail) + parsed_tail
  end
end

IO.puts("12 + 6 = #{Calculator.calculate(~c"12+6")}")
IO.puts("42 * 5 = #{Calculator.calculate(~c"42*5")}")
IO.puts("120 / 30 = #{Calculator.calculate(~c"120/30")}")
