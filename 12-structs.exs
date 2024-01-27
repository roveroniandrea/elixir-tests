# A struct is a map with a fixed set of fields (keys) and default values
# A struct can be pattern-matched by type as well as value
#
# Structs are modules that defines maps with some constraints:
# keys must be atoms (no dynamic values or variables)
# They do not have dictionary capabilities
defmodule SubscriberUser do
  defstruct forename: "", surname: "", has_premium_battle_pass: false
end

# NOTE: I had to wrap the entire code into a module, because I'm currently running this script using `elixir <filename>` command
# For some "limitations" in the way .exs files are compiled, the following error will rise if I do not wrap into a module:
#  `cannot access struct SubscriberUser, the struct was not yet defined or the struct is being accessed in the same context that defines it`
# Because SubscriberUser is in the same context I suppose.
# see https://stackoverflow.com/questions/39576209/elixir-cannot-access-struct
# Loading the file with `iex <filename>` instead, works
defmodule MyCode_1 do
  def main do
    # Structs are created in a similar way of how maps are created
    subscriber_1 = %SubscriberUser{}

    # Here I can override some default values
    subscriber_2 = %SubscriberUser{
      forename: "NoobMaster69",
      surname: nil,
      has_premium_battle_pass: true
    }

    IO.puts("Subscriber 1 has default values: #{inspect(subscriber_1)}")
    IO.puts("Subscriber 2: #{inspect(subscriber_2)}")

    # As structs defines a specific set of keys, I cannot add new arbitrary keys
    # This will raise `key :is_hacker not found`
    # subscriber_3 = %SubscriberUser{
    #  is_hacker: true
    # }

    # Fields can be accessed and updated like in normal maps
  end
end

# Calling my code
MyCode_1.main()

#
# Structs are wrapped in modules because this allows to write specific code to interact with that struct

defmodule Jedi do
  defstruct name: "", lightsaber_color: "", is_grand_master: false

  # Note how we can pattern-match by type! Passing a value different from a Jedi struct will not match
  def getName(jedi = %Jedi{}), do: jedi.name

  # Only grand masters can have epic entrances
  def epic_entrance(%Jedi{name: name, lightsaber_color: color, is_grand_master: true})
      when name != "" and color != "" do
    "Grand master #{name} turns on his #{color} lighsaber"
  end
end

#
#
defmodule MyCode_2 do
  def main() do
    # Seems like Ani does't have the rank of master!
    anakin = %Jedi{name: "Anaking Skywalker", lightsaber_color: "Blue"}
    IO.puts(Jedi.getName(anakin))

    mace_windu = %Jedi{name: "Mace Windu", lightsaber_color: "Purple", is_grand_master: true}

    IO.puts(Jedi.epic_entrance(mace_windu))

    # Ani cannot have epic entrances
    # IO.puts(Jedi.epic_entrance(anakin))

    # This will raise an error
    # NOTE: Even if the parameter has all keys present in `Jedi` structure, it's not typed as a Jedi!
    # This means that pattern-match against types is strongly typed
    # IO.puts(Jedi.getName(%{name: "Darth Maul", lightsaber_color: "", is_grand_master: false}))
  end
end

MyCode_2.main()

#
#
# Structs can be nested
defmodule Videogame do
  defstruct title: "", rating: 0
end

defmodule Console do
  # Originally I wanted to make a list of Videogame, but let's keep it simple
  defstruct name: "", currently_playing: %Videogame{}
end

defmodule MyCode_3 do
  def main() do
    polystation = %Console{
      name: "Polystation",
      currently_playing: %Videogame{title: "Carlos el topo que gira", rating: 5}
    }

    IO.puts("I'm playing \"#{polystation.currently_playing.title}\" on my #{polystation.name}")

    # Updating a nested property can be done like in JS with the spreading operator, but is equally verbose:
    updated_polystation = %Console{
      polystation
      | currently_playing: %Videogame{polystation.currently_playing | title: "Minesweeper"}
    }

    IO.puts("Updated polystation: #{inspect(updated_polystation)}")

    # Fortunately, Elixir has some helper functions
    # I don't know how `put_in` resolves the first argument as a path (I expected some kind of string value)
    # But the function documentation calls it a "macro", so I suppose it has some sort of superpowers
    updated_polystation_2 = put_in(polystation.currently_playing.title, "Pacman")
    IO.inspect(updated_polystation_2)
  end
end

MyCode_3.main()

# There are other macros to access nested values, like  `update_in` that sets a property based on a function result, `get_in` and `get_and_update`
# All of them support a normal function variant, which allows to specify a dynamic path instead of a static one like before
# Some pages with those functions, alongside with `Access` module to filter keys ect
# See pages 91-94
