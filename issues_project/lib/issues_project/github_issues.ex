defmodule IssuesProject.GithubIssues do
  @moduledoc """
  Handles Github API
  """

  # A user agent is required by Github API
  @user_agent [{"User-agent", "Elixir test"}]

  @doc """
  Fetches issues
  """
  def fetch(username, project) do
    issues_url(username, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response()
  end

  @doc """
  Returns url in order to retrieve issues
  """
  def issues_url(username, project),
    do: "https://api.github.com/repos/#{username}/#{project}/issues"

  @doc """
  Handles an HTTPoison Response, which may succeed or not.
  Returns a tuple with first element :ok or :error, and second the body, or error reason
  """
  def handle_response(http_poison_response)

  def handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}) do
    {:ok, body}
  end

  def handle_response({:ok, %HTTPoison.Response{status_code: _, body: body}}) do
    {:error, body}
  end

  def handle_response({:error, %HTTPoison.Error{reason: reason}}) do
    {:error, reason}
  end
end
