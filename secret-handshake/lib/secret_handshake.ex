defmodule SecretHandshake do
  use Bitwise
  @moves %{0b1 => "wink", 0b10 => "double blink", 0b100 => "close your eyes", 0b1000 => "jump"}
  @reversed_moves %{0b1000 => "wink", 0b100 => "double blink", 0b10 => "close your eyes", 0b1 => "jump"}

  @doc """
  Determine the actions of a secret handshake based on the binary
  representation of the given `code`.

  If the following bits are set, include the corresponding action in your list
  of commands, in order from lowest to highest.

  1 = wink
  10 = double blink
  100 = close your eyes
  1000 = jump

  10000 = Reverse the order of the operations in the secret handshake
  """
  @spec commands(code :: integer) :: list(String.t())

  def commands(code) when (code &&& 0b10000) === 0b10000 do
    do_commands(@moves, code)
      |> Enum.reverse
  end

  def commands(code) do
    do_commands(@moves, code)
  end

  def do_commands(commands, code) do
    commands
      |> Enum.filter(fn {k, _} -> (code &&& k) === k end)
      |> Enum.map(fn {_, v} -> v end)
  end
end
