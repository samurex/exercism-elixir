defmodule ProteinTranslation do
  @doc """
  Given an RNA string, return a list of proteins specified by codons, in order.
  """
  @codons %{
    "UGU" => "Cysteine",
    "UGC" => "Cysteine",
    "UUA" => "Leucine",
    "UUG" => "Leucine",
    "AUG" => "Methionine",
    "UUU" => "Phenylalanine",
    "UUC" => "Phenylalanine",
    "UCU" => "Serine",
    "UCC" => "Serine",
    "UCA" => "Serine",
    "UCG" => "Serine",
    "UGG" => "Tryptophan",
    "UAU" => "Tyrosine",
    "UAC" => "Tyrosine",
    "UAA" => "STOP",
    "UAG" => "STOP",
    "UGA" => "STOP"
  }

  def of_rna(rna) do
    parsed = rna
      |> String.to_charlist
      |> Enum.chunk_every(3)
      |> Enum.map(&to_string/1)
      |> Enum.map(&of_codon/1)
      |> Enum.map(fn
        {:ok, codon} -> codon
        {:error, _} -> {:error, "invalid RNA"}
      end)
      |> Enum.take_while(&(&1 !== "STOP"))

    parsed
      |> Enum.find(&match?({:error, _}, &1))
      |> case do
        nil -> {:ok, parsed}
        error -> error
      end
  end

  @doc """
  Given a codon, return the corresponding protein

  UGU -> Cysteine
  UGC -> Cysteine
  UUA -> Leucine
  UUG -> Leucine
  AUG -> Methionine
  UUU -> Phenylalanine
  UUC -> Phenylalanine
  UCU -> Serine
  UCC -> Serine
  UCA -> Serine
  UCG -> Serine
  UGG -> Tryptophan
  UAU -> Tyrosine
  UAC -> Tyrosine
  UAA -> STOP
  UAG -> STOP
  UGA -> STOP
  """
  @spec of_codon(String.t()) :: {atom, String.t()}
  def of_codon(codon) do
     case @codons[codon] do
      nil -> {:error, "invalid codon"}
      codon -> {:ok, codon}
     end
  end
end
