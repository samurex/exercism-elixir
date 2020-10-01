defmodule RnaTranscription do
  @doc """
  Transcribes a character list representing DNA nucleotides to RNA

  ## Examples

  iex> RnaTranscription.to_rna('ACTG')
  'UGAC'
  """
  @spec to_rna([char]) :: [char]
  def to_rna([]), do: []
  def to_rna([h|t]) do
    [translate(h) | to_rna(t)]
  end

  defp translate(letter) do
    case letter do
      ?G -> ?C
      ?C -> ?G
      ?T -> ?A
      ?A -> ?U
      _ -> raise "Not a DNA"
    end
  end
end
# G -> C
# C -> G
# T -> A
# A -> U
