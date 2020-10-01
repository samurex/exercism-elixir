defmodule SumOfMultiples do
  @doc """
  Adds up all numbers from 1 to a given end number that are multiples of the factors provided.
  """
  @spec to(non_neg_integer, [non_neg_integer]) :: non_neg_integer
  def to(limit, factors) do
    factors
      |> Enum.map(fn
        f -> Enum.filter(1..(limit - 1), fn l -> rem(l, f) == 0
        end)
      end)
      |> List.flatten
      |> Enum.uniq
      |> Enum.sum
  end
end
