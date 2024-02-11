# Convention states that modules should be prefixed with project name and respect file naming
defmodule IssuesProject.CLI do
  @moduledoc """
  Handles the command line parsing and the dispatch to the various functions
  """

  # This is the default issues count if not passed as cli argument
  @default_count 4

  def run(argv) do
    parse_args(argv)
    |> process()
  end

  @doc """
  `argv` can be -h or --help, which returns :help

  Otherwise it is a github username, project name and (optionally) the number of entries to format.
  Returns a tuple of `{user, project, count}`, or :help if help was given
  """
  def parse_args(argv) do
    # Using an Elixir base library to parse cli arguments
    # "switches" are "flags", those who start with `--`
    # Here is defined the `--help` switch, that is expected to be a boolean
    # And also can be aliased as `-h`

    # The result is a triple consisting in a keyword list of parsed switches, remaining arguments (not switches), and invalid options (switches?)
    parsed = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    decode_parsed_args(parsed)
  end

  defp decode_parsed_args(args)
  # Help switch is passed
  defp decode_parsed_args({[help: true], _, _}), do: :help
  # Full arguments
  defp decode_parsed_args({_, [github_username, github_project, issues_count], _}),
    do: {github_username, github_project, String.to_integer(issues_count)}

  # Or without count, so default to @default_count
  defp decode_parsed_args({_, [github_username, github_project], _}),
    do: {github_username, github_project, @default_count}

  @doc """
  Handles :help command,
  or retrieves infos from Github
  """
  def process(cmds)

  def process(:help) do
    IO.puts("""
    Usage: issuesProject <github_username> <github_project> [issues_count | #{@default_count}]
    """)

    # Exit the program (this causes a Dialized warning because it cannot find any path that returns some value)
    System.halt(0)
  end

  def process({github_username, github_project, issues_count}) do
    raise "Not implemented"
  end
end
