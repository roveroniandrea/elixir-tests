global_var = 0

if(global_var == 0) do
  # This sets an inner variable but does not change the value outside
  global_var = 1
  # String interpolation via #{}
  IO.puts("Inner: #{global_var}")
end

IO.puts(global_var)

# This instead works
global_var_2 = 0

global_var_2 =
  if global_var_2 == 0 do
    global_var_2 = 1
    # String interpolation via #{}
    IO.puts("Inner: #{global_var_2}")
    # Return the value from the if
    global_var_2
  end

IO.puts(global_var_2)
