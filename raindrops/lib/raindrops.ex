defmodule Raindrops do
  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) do
    ["Pling", "Plang", "Plong"]
      |> Enum.zip([rem(number, 3), rem(number, 5), rem(number, 7)])
      |> Enum.filter(fn {_, n} -> n == 0 end)
      |> Enum.map(fn {w, _} -> w end)
      |> Enum.join
      |> case do
        "" -> to_string(number)
        rain -> rain
      end
  end
end
