defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count > 0 do
    Stream.unfold(1, fn
      n ->
        prime = next_prime(n)
        {prime, prime + 1}
    end) |> Enum.at(count - 1)
  end

  defp next_prime(number) do
    case is_prime?(number) do
      true -> number
      false -> next_prime(number + 1)
    end
  end

  defp is_prime?(1), do: false
  defp is_prime?(2), do: true
  defp is_prime?(number) do
    last = number
      |> :math.sqrt
      |> ceil

    1..last
      |> Enum.filter(&(rem(number, &1) == 0))
      |> Enum.count == 1
  end
end
