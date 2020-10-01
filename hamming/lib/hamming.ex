defmodule Hamming do
  @doc """
  Returns number of differences between two strands of DNA, known as the Hamming Distance.

  ## Examples

  iex> Hamming.hamming_distance('AAGTCATA', 'TAGCGATC')
  {:ok, 4}
  """
  @spec hamming_distance([char], [char]) :: {:ok, non_neg_integer} | {:error, String.t()}
  def hamming_distance(strand1, strand2) when length(strand1) != length(strand2), do:
    {:error, "Lists must be the same length"}

  def hamming_distance(strand1, strand2) do
    mutations = strand1
      |> Enum.zip(strand2)
      |> Enum.filter(fn {n1, n2} -> n1 !== n2 end)
      |> Enum.count

    {:ok, mutations}

  end
end