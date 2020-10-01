defmodule Sublist do
  @doc """
  Returns whether the first list is a sublist or a superlist of the second list
  and if not whether it is equal or unequal to the second list.
  """
  def compare(a, a), do: :equal
  def compare(a, b) do
    case {sublist(a, b), sublist(b, a)} do
      {true, true} -> :equal
      {false, true} -> :superlist
      {true, false} -> :sublist
      {false, false} -> :unequal
    end
  end


  def starts_with([h|ta], [h|tb]), do: starts_with(ta, tb)
  def starts_with([], _), do: true
  def starts_with(_, _), do: false

  def sublist(_, []), do: false
  def sublist(a, [h|t]) do
    starts_with(a, [h|t]) or sublist(a, t)
  end


  def permute(element, list) do

  end
end
