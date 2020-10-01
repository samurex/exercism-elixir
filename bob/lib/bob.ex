defmodule Bob do
  @message_types [
    {~r/^.*[^A-Z]+.*\?\s*$/, :question},
    {~r/^[^a-z]*[A-Z\p{Lu}]+[^a-z]*$/u, :yealing},
    {~r/^[^a-z]*[A-Z\s!]+[^a-z]*\?\s*$/, :yealing_question},
    {~r/^\s*$/, :nothing},
  ]
  def parse(input) do
    {_, type } = Enum.find(@message_types, {input, :whatever}, fn {reg, _} ->
      String.match?(input, reg)
    end)
    {type, input}
  end

  defp do_reply({:question, _}), do: "Sure."
  defp do_reply({:yealing, _}), do: "Whoa, chill out!"
  defp do_reply({:yealing_question, _}), do: "Calm down, I know what I'm doing!"
  defp do_reply({:nothing, _}), do: "Fine. Be that way!"
  defp do_reply({:whatever, _}), do: "Whatever."

  def hey(input) do
    input |> parse |> do_reply
  end
end
