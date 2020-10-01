defmodule StringSeries do
  @doc """
  Given a string `s` and a positive integer `size`, return all substrings
  of that size. If `size` is greater than the length of `s`, or less than 1,
  return an empty list.
  """
  @spec slices(s :: String.t(), size :: integer) :: list(String.t())
  def slices(s, size) do
    max_index = String.length(s) - size
    case {max_index, size} do
      _ when max_index < 0 or size <= 0 -> []
      _ -> 0..(String.length(s) - size)
              |> Enum.map(fn i -> String.slice(s, i, size) end)
      end
    end
  end
