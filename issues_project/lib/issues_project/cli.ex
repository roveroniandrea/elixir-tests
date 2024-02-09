# Convention states that modules should be prefixed with project name and respect file naming
defmodule IssuesProject.CLI do
  @moduledoc """
  Handles the command line parsing and the dispatch to the various functions
  """

  # This is the default issues count if not passed as cli argument
  @default_count 4

  def run(argv) do
    parse_args(argv)
  end

  @doc """
  `argv` can be -h or --help, which returns :help

  Otherwise it is a github username, project name and (optionally) the number of entries to format.
  Returns a tuple of `{user, project, count}`, or _help if help was given
  """
  def parse_args(argv) do
    # Using an Elixir base library to parse cli arguments
    # "switches" are "flags", those who start with `--`
    # Here is defined the `--help` switch, that is expected to be a boolean
    # And also can be aliased as `-h`

    # The result is a triple consisting in a keyword list of parsed switches, remaining arguments (not switches), and invalid options (switches?)
    parsed = OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])

    case parsed do
      # Help switch is passed
      {[help: true], _, _} ->
        :help

      # Full arguments
      {_, [github_username, github_project, issues_count], _} ->
        {github_username, github_project, String.to_integer(issues_count)}

      # Or without count, so default to @default_count
      {_, [github_username, github_project], _} ->
        {github_username, github_project, @default_count}

      # Otherwise something is wrong, defaults to help
      _ ->
        :help
    end
  end
end
