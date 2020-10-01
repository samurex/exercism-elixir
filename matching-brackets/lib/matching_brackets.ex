defmodule MatchingBrackets do
  @doc """
  Checks that all the brackets and braces in the string are matched correctly, and nested correctly
  """
  @spec check_brackets(String.t()) :: boolean
  def check_brackets(str) do
    do_check_brackets(str, [])
  end

  def do_check_brackets("", []), do: true
  def do_check_brackets("", _), do: false

  def do_check_brackets(<<char::utf8, rest::binary>>, stack) when char in [?[,?(,?{] do
    do_check_brackets(rest, [char|stack])
  end

  def do_check_brackets(<<char::utf8, rest::binary>>, [last|stack]) when char in [?],?),?}] do
    IO.puts "closing" <> to_string([char]) <> "last:" <> to_string([last])
    case char do
      ?] when last == ?[ -> do_check_brackets(rest, stack)
      ?) when last == ?( -> do_check_brackets(rest, stack)
      ?} when last == ?{ -> do_check_brackets(rest, stack)
      _ -> false
    end
  end

  def do_check_brackets(<<_::utf8, rest::binary>>, stack) do
    IO.puts "here"
    do_check_brackets(rest, stack)
  end
end
