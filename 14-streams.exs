# The Enum module is greedy, meaning that will iterate (potentially) the entire collection that receives in input
# This means that calling subsequent Enum functions will create n intermediate collections, even ehen using the pipe operator

IO.puts("\n--- INIT ENUM ---")

my_list =
  1..5
  # Doubling each value
  |> Enum.map(fn el ->
    IO.puts("Enum.map/2 of element #{el}")
    el * 2
  end)
  # Keeping only even values
  |> Enum.filter(fn el ->
    IO.puts("Enum.filter/2 of element #{el}")
    rem(el, 2) == 0
  end)

# Previous IO.puts have already been printed before each line. This is because Enum is greedy
# Also, note that all Enum.map/2 are printed before all Enum.filter/2
IO.puts(
  "Previous IO.puts have already been printed before each line. This is because Enum is greedy"
)

IO.puts("List 1 is: #{inspect(my_list)}")

#
#
IO.puts("\n--- INIT STREAM ---")

# Instead, streams are lazy enumerable, meaning that the next value is calculated only when needed
# and only after the previous one has been through ALL the transformations defined in the stream
my_stream =
  1..5
  # Doubling each value
  |> Stream.map(fn el ->
    IO.puts("Stream.map/2 of element #{el}")
    el * 2
  end)
  # Keeping only even values
  |> Stream.filter(fn el ->
    IO.puts("Stream.filter/2 of element #{el}")
    rem(el, 2) == 0
  end)

# Read comment
IO.puts(
  "Previous IO.puts called by steam functions are not yeat printed. This is because Stream module is lazy"
)

IO.puts("This is the inspected stream: #{inspect(my_stream)}")

# Now, when actually consuming the stream (for example by converting to a list), each stream element will be consumed
#
# Also, note the order of IO.puts:
# They're obviously called before this final IO.puts, but EACH ELEMENT IS TOTALLY CONSUMED before continuing with the next one
# So Stream.map/2 is called for index 0, then Stream.filter for index 0
# Then Stream.map/2 is called for index 1, then Stream.filter for index 1
# And so on
IO.puts("List 2 is: #{inspect(Enum.to_list(my_stream))}")

#
#
# DIFFERENCES
#
# STREAM GOOD FOR -> Stream module takes less memory then Enum, because there are no intermediate collections,
#                     and are evaluated only when needed
# ENUM GOOD FOR -> On the other hand, Enum is faster (the book says two times faster)

# Streams might be the optimal way when handling files
stream_to_write =
  1..200
  |> Stream.map(&"This is line number #{&1}")
  # Adding a newline. Yes, this could have been done in the previous step
  |> Stream.map(&"#{&1}\n")

# This is a bit tricky, but what does is opening a file as stream, and writing `stream_to_write` into the other
# Also, I initially used `Enum.into` as suggested on stackoverflow, but on Elixir forum this is another possibility
# I do not know if using `Stream.into` makes any difference in how writing is handled
Stream.into(stream_to_write, File.stream!("files/14-streams.txt"))
# Anyway, this `.run()` allows the stream to be consumed, because `Stream.into` returns a Stream itself, so it's lazy
|> Stream.run()

# Reading the same file
first_line_reversed =
  File.open!("files/14-streams.txt")
  # Convert the file (aka "device") into a stream, with one element for each line
  |> IO.stream(:line)
  # Do something. I decided to keep a Stream at any cost, so counting total lines required to convert into an Enum
  # So I decided to just take the first line and reverse it
  # The interesting thing is that the order of these two instructions does not matter
  # because the entire stream will always stop after the first element
  |> Stream.map(fn line ->
    IO.puts("This will be printed only once")
    String.reverse(line)
  end)
  |> Stream.take(1)

IO.puts(Enum.at(first_line_reversed, 0))
