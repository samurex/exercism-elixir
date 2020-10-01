defmodule WordCount do
  @doc """
  Count the number of words in the sentence.

  Words are compared case-insensitively.
  """
  @spec count(String.t()) :: map
  def count(sentence) do
    Regex.scan(~r/[a-zA-ZÀ-ÿ0-9-]+/, sentence)
      |> List.flatten
      |> Enum.map(&String.downcase/1)
      |> Enum.reduce(%{}, fn (word, acc) ->
        Map.update(acc, word, 1, &(&1 + 1))
      end)
  end
end
