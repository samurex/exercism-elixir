defmodule AllYourBase do
  @doc """
  Given a number in base a, represented as a sequence of digits, converts it to base b,
  or returns nil if either of the bases are less than 2
  """

  @spec convert(list, integer, integer) :: list | nil
  def convert(_, base_a, base_b) when base_a < 2 or base_b < 2, do: nil
  def convert(digits, base_a, base_b) do
    case is_valid?(digits, base_a) do
      true ->
        digits
          |> decode(base_a)
          |> encode(base_b, [])
      false -> nil
    end
  end

  defp is_valid?([], _), do: false
  defp is_valid?(digits, base) do
    digits
      |> Enum.find(fn n -> n >= base or n < 0 end) == nil
  end

  defp decode(digits, base) do
    digits
      |> Enum.reverse
      |> Enum.with_index
      |> Enum.reduce(0, fn {digit, i}, acc -> acc + digit * :math.pow(base, i) end)
      |> trunc
  end

  defp encode(0, _, []), do: [0]
  defp encode(0, _, acc), do: acc
  defp encode(number, base, acc) do
    digit = rem(number, base)
    rest = div(number, base)
    encode(rest, base, [digit| acc])
  end
end
