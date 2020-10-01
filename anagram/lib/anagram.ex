defmodule Anagram do
  @doc """
  Returns all candidates that are anagrams of, but not equal to, 'base'.
  """
  @spec match(String.t(), [String.t()]) :: [String.t()]
  def match(base, candidates) do
    candidates
      |> Enum.filter(&is_anagram(&1, base))
  end

  def is_anagram(candidate, base) do
    base = normalize(base)
    candidate = normalize(candidate)

    base != candidate &&
    Enum.sort(candidate) == Enum.sort(base)
  end

  def normalize(string) do
    string
      |> String.downcase
      |> String.to_charlist
  end
end
