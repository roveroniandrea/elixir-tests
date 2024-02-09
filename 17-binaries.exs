# The binaty type represents a sequence of bits
# Each number is stored as a consecutive byte
b = <<1, 2, 3>>

# b has 3 bytes
IO.puts("b has #{byte_size(b)} bytes, or #{bit_size(b)} bits")

# The ::size modifier allows to keep just some number of bits
# This will put 01 001 into b_2
b_2 = <<1::size(2), 1::size(3)>>
# So the result should be 0x01001 = 9
IO.puts("b_2 is #{inspect(b_2)}")

# Pattern matching works on binaries too
# For example, here we can extract the different parts of a IEEE 756 floating point variable (64 bits)
# Most significant bit is the sign, then 11 bits for the exponent, then 52 bits for the mantissa
<<sign::size(1), exponent::size(11), mantissa::size(52)>> = <<3.1415926535::float>>

IO.puts(
  "PI is #{(1 + mantissa / :math.pow(2, 52)) * :math.pow(2, exponent - 1023) * (1 - 2 * sign)}"
)

#
# Double quoted strings (but not character lists) are stored as binaries
my_str = "Example of a string"

# Note: some utf8 characters are longer than one byte, so byte_size might be higher the string size
IO.puts("As string: #{String.length(my_str)}, as binary: #{byte_size(my_str)}")

# Some String functions... read the book

# Exercise: Write a function that takes a list of double quoted strings and outputs them centered vertically
# Al string length must be even in order to place at the exact center
defmodule PrintStrings do
  def print(string_list) do
    # Retrieve the maximum length in all strings
    max_length = Enum.reduce(string_list, 0, &Enum.max([String.length(&1), &2]))

    Enum.map(string_list, &pad(&1, max_length))
    |> Enum.join("\n")
  end

  defp pad(str, total_length) do
    missing_padding = total_length - String.length(str)

    "#{String.pad_leading("", div(missing_padding, 2), " ")}#{str}#{String.pad_leading("", div(missing_padding, 2), " ")}"
  end
end

IO.puts(PrintStrings.print(["cat", "zebra", "elephant"]))


# Something else regarding binaries pattern matching
