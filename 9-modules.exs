# Modules can be nested
defmodule Outer do
  defmodule Inner do
    def innerCall, do: "Hello modules"
  end
end

IO.puts(Outer.Inner.innerCall())

# However, behind the scenes Elixir compiles all of them as top modules with a prefix, like so
defmodule Outer.Inner2 do
  def innerCall, do: "Hello modules"
end

IO.puts(Outer.Inner2.innerCall())

# The `import` directive allows to import a module's functions or macron inside the current scope
# Outside the scope, that import has no effect
defmodule ImportingModule do
  def flatten_list_1(l) do
    # It's possible to import the entire module
    import List
    flatten(l)
  end

  def flatten_list_2(l) do
    # Or import only some functions/macros, with the syntax is [function_name:arity, function_name_2:arity_2]
    import List, only: [flatten: 1]
    flatten(l)

    # This is List.delete, that accepts a value (not an index) to delete from a list, returning the list without that element
    # This function will be undefined if not inported with `only: [flatten: 1, delete: 2]`
    # delete(l, 1)
  end

  # Optionally, you can import only all functions, only all macros, or use `except` instead of `only`
  def flatten_list_3(l) do
    # Or import only some functions/macros, with the syntax is [function_name:arity, function_name_2:arity_2]
    import List, except: [delete: 2]
    flatten(l)
  end
end

IO.puts(inspect(ImportingModule.flatten_list_1([1, [2, 3], 4])))
IO.puts(inspect(ImportingModule.flatten_list_2([1, [2, 3], 4])))
IO.puts(inspect(ImportingModule.flatten_list_3([1, [2, 3], 4])))

# The `alias` directive imports a module with a different name
defmodule AliasModule do
  def flatten_list_1(l) do
    # Seems that specifying `only:` does not work
    alias List, as: ListModule
    ListModule.flatten(l)
  end
end

IO.puts(inspect(AliasModule.flatten_list_1([1, [2, 3], 4])))

#
# There's another directive, `require`, that is used for macros. For not let's skip it
#

# Modules can have `attributes`, or metadata, defined with @ symbol
defmodule ModuleWithAttributes do
  # They are not exactly variables or properties. Instead they are used to define configuration or metadata in a module
  @forename "Ahsoka"
  @surname "Tano"

  def not_a_jedi(), do: "#{@forename} #{@surname}"
end

IO.puts(ModuleWithAttributes.not_a_jedi())

# Modules are compiled as atoms, so we can do:
# But this is just in order to better understand how to call Erlang modules (as follows)
IO.puts(:"Elixir.ModuleWithAttributes".not_a_jedi())

# As said, Erlang modules can be used in Elixir without prior configurations
# However, Elixir imports them with a small syntax different
# For example, calling the `tc` function in the Erlang's `timer` module (converted into an antom) would be written as timer.tc
# In Elixir, atoms are prefixed with colons, so
# (Note: I actually don't know what is this tc function, maybe to measure execution time of a function)
IO.inspect(:timer.tc(fn -> 3 end))

# Excercises
to_fixed = fn value -> Float.to_string(value, decimals: 2) end
IO.puts(to_fixed.(3.1415926535))

# Seems that Float.to_string is deprecated, let's use erlang modules instead
IO.puts(:erlang.float_to_binary(3.1415926535, [{:decimals, 2}]))

# Get the value of an OS env variable
IO.puts("Path OS variable is: #{System.get_env("PATH")}")

# Return the extension of a file
IO.puts(Path.extname("./folder/myFile.txt"))

# Return cwd
{:ok, cwd} = File.cwd()
IO.puts("Cwd: #{cwd}")

# Execute shell command WAIT WAIT WAIT
IO.inspect(System.cmd("echo", ["\"Hola shell!\""]))
