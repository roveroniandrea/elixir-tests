# Comprehensions allows to iterate, filter and map collections in a compact syntax
# Syntax is the following:
# result = for `generator or filter`... [, into: `value`], do: `expression`
#
# Where `generator or filter` are one or more "things", that can either generate a value, or filter values.
# Generators have the syntax `pattern <- enumerable` and matches the variable `pattern` allowing to reuse further in the comprehension
# Filters are predicates that allows to keep only certain values
#
# `expression` remaps each generated value(s)
#
# `into` is more complex, but allows to specify a Collectable in which to put each result of `expression`
# If not specified, befaults to a list. This if why the entire comprehension returns a list by default
# But instead if might be a map, so now the generator will return a map

# Demonstrating a single generator
squared_values = for x <- 1..5, do: x * x

squared_values_2 =
  1..5
  |> Enum.map(&(&1 * &1))

# These two lists are the same
IO.puts("These lists are equal: #{inspect(squared_values)} and #{inspect(squared_values_2)}")

# Multiple generators are like nested for cycles:
coordinates = for x <- 1..3, y <- 1..4, do: {x, y}
IO.puts("Nested generators: #{inspect(coordinates)}")

# Demonstrating a filter, by generating pair of numbers from 1 to 8 but keeping only if their product is multiple of 10
# Also, the second generator uses values provided by the first one in order to not print inverted tuples, like {2, 5} and {5, 2}
multiple_of_10 = for a <- 1..8, b <- a..8, rem(a * b, 10) == 0, do: {a, b}
IO.puts("Multiples of 10: #{inspect(multiple_of_10)}")

# Using `into` to return a map instead of a list
defmodule User do
  defstruct id: "", forename: "", is_admin: false
end

# Remember that a struct cannot be used in the same scope where is declared, so I have to use a wrapper module
defmodule MyCode do
  def main() do
    users_by_id =
      for id <- 1..10,
          into: %{},
          do: {id, %User{id: id, forename: "User number #{id}", is_admin: rem(id, 2) == 0}}

    users_by_id
  end
end

IO.puts("Users by their id are: #{inspect(MyCode.main())}")

# Excercises
#
# Ex 1: Return prime numbers from 2 to n using comprehension
defmodule PrimeNumbers do
  def primes(upper_value) when upper_value >= 2 do
    for n <- 2..upper_value, is_prime(n), do: n
  end

  # Private functions to check if a number is prime
  # 2 is prime
  defp is_prime(2), do: true
  # Otherwise, check for all previous divisors
  defp is_prime(n) do
    2..(n - 1)
    |> Enum.all?(&(rem(n, &1) != 0))
  end
end

IO.puts("Prime numbers from 2 to 20: #{inspect(PrimeNumbers.primes(20))}")

#
# Ex 2: Calculate total amount to each order based on taxes for that country. If order if from different county, no taxes are applied
# (North Carolina and Texas by the way). This is a keywork list
tax_rates = [NC: 0.075, TX: 0.08]

orders = [
  [id: 123, ship_to: :NC, net_amount: 100.00],
  [id: 124, ship_to: :OK, net_amount: 35.50],
  [id: 125, ship_to: :TX, net_amount: 24.00],
  [id: 126, ship_to: :TX, net_amount: 44.80],
  [id: 127, ship_to: :NC, net_amount: 25.00],
  [id: 128, ship_to: :MA, net_amount: 10.00],
  [id: 129, ship_to: :CA, net_amount: 102.00],
  [id: 130, ship_to: :NC, net_amount: 50.00]
]

taxes_applied =
  for order <- orders do
    # dot notation can only be used on maps, not keyword lists
    # Also, instead of checking for the key and doing and if/do/else block, I can just go for a default value instead
    tax_rate = Keyword.get(tax_rates, order[:ship_to], 1)

    Keyword.put_new(order, :total_amount, order[:net_amount] * tax_rate)
  end

IO.puts("Taxes applied: #{inspect(taxes_applied)}")
