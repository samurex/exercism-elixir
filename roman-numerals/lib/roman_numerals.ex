defmodule RomanNumerals do
  @doc """
  Convert the number to a roman number.
  """
  @spec numeral(number) :: String.t()
  def numeral(number) do
    numeral(number, [1000, 100, 10, 1])
    # to_roman = decimals()
    # case number do
    #   _ when number == 0 -> ""
    #   _ when number <= 10 -> to_roman[number]
    #   _ when number > 10 and number <= 100 ->
    #       rest = rem(number, 10)
    #       to_roman[number - rest] <> numeral(rest)
    #   _ when number > 100  and number <= 1000 ->
    #       rest = rem(number, 100)
    #       to_roman[number - rest] <> numeral(rest)
    #    _ when number > 1000 and number < 3000 ->
    #       rest = rem(number, 1000)
    #       String.duplicate(to_roman[1000], div(number, 1000)) <> numeral(rest)
    # end
  end

  defp numeral(0, _), do: ""
  defp numeral(number, [factor | next ]) when factor > number do
    numeral(number, next)
  end
  defp numeral(number, [factor | next ]) when factor <= number do
    to_roman = decimals()
    rest = rem(number, factor)
    to_roman[number - rest] <> numeral(rest, next)
  end

  def roman_to_decimal(roman) do
    roman
      |> roman_to_list([])
      |> list_to_int

  end

  def roman_to_list([h|t], acc) do
    map = romans()
    roman_to_list(t, [map[to_string([h])] | acc])
  end
  def roman_to_list([], acc), do: acc

  def list_to_int([h1 |[ h2 | t]]) when h1 < h2 do
    h2 - h1 + list_to_int(t)
  end
  def list_to_int([h|t]) do
    h + list_to_int(t)
  end
  def list_to_int([]), do: 0

  # basic combinations
  def romans, do: %{
    "I" => 1,
    "II" => 2,
    "III" => 3,
    "IV" => 4,
    "V" => 5,
    "VI" => 6,
    "VII" => 7,
    "VIII" => 8,
    "IX" => 9,
    "X" => 10,
    "XX" => 20,
    "XXX" => 30,
    "XL" => 40,
    "L" => 50,
    "LX" => 60,
    "LXX" => 70,
    "LXXX" => 80,
    "XC" => 90,
    "C" => 100,
    "CC" => 200,
    "CCC" => 300,
    "CD" => 400,
    "D" => 500,
    "DC" => 600,
    "DCC" => 700,
    "DCCC" => 800,
    "CM" => 900,
    "M" => 1000,
  }
  def decimals, do: Map.new(romans(), fn {key, val} -> {val, key} end)



  # def number_to_array(number, acc, n) when number < 10, do: translate_digit(number, n) <> acc
  # def number_to_array(number, acc, n) do
  #   digit = rem(number, 10)
  #   number = div(number, 10)
  #   number_to_array(number, translate_digit(digit, n ) <> acc, n + 1)
  # end

  # def number_to_array2([h|t], factor) when number < 10, do: translate_digit(number, n) <> acc
  # def number_to_array2([h|t], factor) do
  #   digit = div(number, factor)
  #   number = div(number, 10)
  #   number_to_array(number, translate_digit(digit, n ) <> acc, n + 1)
  # end


  # def factors(i) when i in [0,1,2] do
  #   case i do
  #     0 -> %{"first" => "I", "middle" => "V", "end" => "X"}
  #     1 -> %{"first" => "X", "middle" => "L", "end" => "C"}
  #     2 -> %{"first" => "C", "middle" => "D", "end" => "M"}
  #   end
  # end

  # def translate_digit(digit, factor) when factor in [0,1,2] do
  #   letters = factors(factor)
  #   case digit do
  #     0 -> ""
  #     _ when digit in [1,2,3] -> String.duplicate(letters["first"], digit)
  #     _ when digit == 4 -> letters["first"] <> letters["middle"]
  #     _ when digit == 5 -> letters["middle"]
  #     _ when digit in [6,7,8] -> letters["middle"] <> String.duplicate(letters["first"], digit - 5)
  #     _ when digit == 9 -> letters["first"] <> letters["end"]
  #   end
  # end
  # def translate_digit(digit, factor) when factor == 3 do
  #   String.duplicate("M", digit)
  # end
end
