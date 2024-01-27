# Keywork lists and maps are dictionaries

# Keywork lists are typically used when passing options to functions
# They can have more entries with the same key
# Also, values are ordered
defmodule Canvas do
  # Use an attribute to define default config
  @default_config [foreground: "black", background: "white", font: "Merriweather"]
  # This is syntactic sugar for a list of tuples
  # @default_config [{:foreground, "black"}, {:background, "white"}, {:font, "Merriweather"}]

  # This might be a function used to draw some text with custom style
  def draw_text(text, config \\ []) do
    # Merging the default config with the one passed as input
    # The latest keywork list has priority
    config = Keyword.merge(@default_config, config)

    IO.puts("Drawing #{text}")

    # Values can be accessed by specifiyng the key
    # (remember: as keywork list are syntactic sugar for list of tuples, keys are atoms)
    IO.puts("With foreground color: #{config[:foreground]}")
    IO.puts("With background color: #{config[:background]}")
    IO.puts("With font: #{config[:font]}")
    IO.puts("With font: #{config[:font]}")
    IO.puts("Config is #{inspect(config)}")
  end
end

# So here there's an optional `config` list  that can be populated
Canvas.draw_text("Hello keywork lists!", foreground: "yellow", unused_config: "Lorem ipsum")

#
# Maps are used as key-value structures
# They have good performance at all sizes
# But keys must be unique and values are not orderer
#
# Elements syntax is similar to keyword lists
my_map = %{name: "Dave", likes: "Programming", where: "Dallas"}

# The `Map` module has some utility functions
# NOTE: All operations do not modify the original map, they're never in-place

IO.puts("Keys are: #{inspect(Map.keys(my_map))}")
IO.puts("Values are: #{inspect(Map.values(my_map))}")

# Values can be accessed with keys, like keywork lists
IO.puts("Name is #{my_map[:name]}")
# Also with dot notation
IO.puts("Name is #{my_map.name}")

# Keys can be removed
IO.puts("Remaining keys are: #{inspect(Map.drop(my_map, [:likes, :where]))}")

# Keys can be added
IO.puts("New keys are: #{inspect(Map.put(my_map, :another_key, "anotherValue"))}")

# Checking if key exists
IO.puts("Key exists: #{inspect(Map.has_key?(my_map, :likes))}")

# Pop allows to remove a key and return its value
{removed_value, updated_map} = Map.pop(my_map, :likes)

IO.puts(
  "Removing key #{:likes} with value #{removed_value} leaves the map as #{inspect(updated_map)}"
)

# Also, two maps can be tested in order to have same key-value pairs
IO.puts("Maps are equal: #{Map.equal?(my_map, Map.put(updated_map, :likes, removed_value))}")

#
# Pattern matching allows to match key-values:
%{name: username} = my_map
IO.puts("Name is #{username}")

# It is also possible to match keys:
keys_to_extract = [:name, :likes]

Enum.map(keys_to_extract, fn key ->
  # If the match succeeds, then the key exists
  # I didn't fully undestand this step: key is atched with the pin operator ^ in order to match its value,
  # but => must be used instead of colon
  # The arrow => can be used when the key is a string (or any other value) instead of a variable
  # But I failed to create a map with a runtime key value (without using the Map.put function)
  %{^key => value} = my_map
  IO.puts("Key #{key} exists and has value #{value}")
end)

# Keys can be updated in the following way
genie_map = %{my_map | name: "Aladdin", likes: "Magic"}

IO.puts("This map will have some keys overwritten: #{inspect(genie_map)}")

# But new keys can't be added in this way
# Decomment to try, will raise `key :is_genie not found`
# IO.puts("This will raise an error: #{inspect(%{genie_map | is_genie: true})}")

# Map.put_new must be used instead
# unlike Map.put, Map.put_new will throw an error if the key already exists
IO.inspect(Map.put_new(genie_map, :is_genie, true))
