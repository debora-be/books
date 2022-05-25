defmodule Books do
  @moduledoc """
  Web scrapper.
  """

  @doc """
  Scraps data from the Elixir-Lang page and parses it to return the name of the books in there.

  ## Example

      iex> Books.get_books()
      ["Elixir in Action – by Saša Jurić",
      "Programming Elixir 1.6: Functional |> Concurrent |> Pragmatic |> Fun – by Dave Thomas",
      "Adopting Elixir: From Concept to Production – by Ben Marx, José Valim, Bruce Tate"]
  """
  def get_books do
    IO.puts "Elixir books"

    case HTTPoison.get("https://elixir-lang.org/learning.html") do
      {:ok, %HTTPoison.Response{body: body}} ->
        content = body
        |> Floki.find("a.cover")
        |> Floki.attribute("title")
        |> Floki.text(sep: "=>")
        |> String.split("=>")

        {:ok, content}
    end
  end

  @doc """
  Adds some characteres in between the lines for a friendly-reading response.

  ## Example

      iex> Books.get_books() |> beautify_content()
      ............................
      Elixir in Action – by Saša Jurić
      ............................
      Programming Elixir 1.6: Functional |> Concurrent |> Pragmatic |> Fun – by Dave Thomas
      ............................
      Adopting Elixir: From Concept to Production – by Ben Marx, José Valim, Bruce Tate
  """
  def beautify_content({_, content}) do
    Enum.map(content, fn elem ->
      IO.puts "  ............................"
      IO.puts "  " <> elem
    end)
  end
end
