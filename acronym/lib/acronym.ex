defmodule Acronym do
  @doc """
  Generate an acronym from a string.
  "This is a string" => "TIAS"
  """
  @spec abbreviate(String.t()) :: String.t()
  def abbreviate(string) do
    string
      |> String.split([" ", "-"])
      |> Enum.map(fn s ->
        cond do
          s =~ ~r/[A-Z][^A-Z]+/ -> Regex.scan(~r/[A-Z][^A-Z]+/, s) |> List.flatten
          s -> s
        end
      end)
      |> List.flatten
      |> Enum.map(fn s -> String.trim(s, "_") end)
      |> Enum.map(fn s -> String.at(s, 0) end)
      |> Enum.join
      |> String.upcase
  end
end
