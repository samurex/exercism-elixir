defmodule RunLengthEncoder do

  @doc """
  Generates a string where consecutive elements are represented as a data value and count.
  "AABBBCCCC" => "2A3B4C"
  For this example, assume all input are strings, that are all uppercase letters.
  It should also be able to reconstruct the data into its original form.
  "2A3B4C" => "AABBBCCCC"
  """
  # @spec encode(String.t()) :: String.t()
  # def encode(string) do
  #   Regex.replace(~r/(.)\1{1,}/, string, fn x, y ->
  #     x
  #       |> String.length
  #       |> to_string
  #       |> Kernel.<>(y)
  #   en
  # end

  @spec encode(String.t()) :: String.t()
  def encode(<<>>), do: ""
  def encode(<<char::utf8, rest::binary>>) do
   do_encode(rest, char, 1, "")
  end

   @spec decode(String.t()) :: String.t()
  def decode(<<char::utf8, rest::binary>>) do
    case char in ?1..?9 do
      true -> do_decode(rest, <<char::utf8>>, "")
      false -> do_decode(rest, "", <<char::utf8>>)
    end
  end

  # @spec decode(String.t()) :: String.t()
  # def decode(string) do
  #   Regex.replace(~r/(\d+)(\w|\s)/, string, fn _, n, l ->
  #     times = String.to_integer(n)
  #     String.duplicate(l, times)
  #   end)
  # end

  def get_code(<<char::utf8>>, n) do
    case n do
      1 -> <<char::utf8>>
      n -> to_string(n) <> <<char::utf8>>
    end
  end

  def do_encode(<<char::utf8, rest::binary>>, char, n, acc) do
    do_encode(rest, char, n + 1, acc)
  end

  def do_encode(<<other::utf8, rest::binary>>, char, n, acc) do
    do_encode(rest, other, 1, acc <> get_code(<<char::utf8>>, n))
  end

  def do_encode("", last, n, acc) do
    acc <> get_code(<<last::utf8>>, n)
  end

  def do_decode(<<number::utf8, rest::binary>>, num_acc, acc) when number in ?1..?9 do
    do_decode(rest, num_acc <> <<number::utf8>>, acc)
  end
  def do_decode(<<char::utf8, rest::binary>>, "", acc) when not(char in ?1..?9) do
    do_decode(rest, "", acc <> <<char::utf8>>)
  end
  def do_decode(<<char::utf8, rest::binary>>, num_acc, acc) when not(char in ?1..?9) do
    n = String.to_integer(num_acc)
    decoded = String.duplicate(<<char::utf8>>, n)
    do_decode(rest, "",  acc <> decoded)
  end
  def do_decode("", _, acc), do: acc
end
