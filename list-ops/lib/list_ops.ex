defmodule ListOps do
  # Please don't use any external modules (especially List or Enum) in your
  # implementation. The point of this exercise is to create these basic
  # functions yourself. You may use basic Kernel functions (like `Kernel.+/2`
  # for adding numbers), but please do not use Kernel functions for Lists like
  # `++`, `--`, `hd`, `tl`, `in`, and `length`.

  @spec count(list) :: non_neg_integer
  def count(l) do
    do_count(l, 0)
  end

  def do_count([], count), do: count
  def do_count([_|t], count) do
    do_count(t, count + 1)
  end

  @spec reverse(list) :: list
  def reverse(list) do
    do_reverse(list, [])
  end

  def do_reverse([], acc), do: acc
  def do_reverse([h|t], acc) do
    do_reverse(t, [h| acc])
  end

  @spec map(list, (any -> any)) :: list
  def map([], _), do: []
  def map([h | t], f) do
    [f.(h) | map(t, f)]
  end

  def filter(l, f), do: do_filter(l, f, []) |> reverse

  def do_filter([], _, acc), do: acc
  def do_filter([h|t], f, acc) do
    case f.(h) do
      true -> do_filter(t, f, [h | acc])
      false -> do_filter(t, f, acc)
    end
  end

  @type acc :: any
  @spec reduce(list, acc, (any, acc -> acc)) :: acc
  def reduce([], acc, _), do: acc
  def reduce([h|t], acc, f) do
    reduce(t, f.(h, acc), f)
  end

  @spec append(list, list) :: list
  def append(a, b) do
    do_append(reverse(a), b)
  end

  def do_append([], b), do: b
  def do_append([reversed_h | reversed_t], b) do
    do_append(reversed_t, [reversed_h | b])
  end

  @spec concat([[any]]) :: [any]
  def concat([]), do: []
  def concat([[a]]), do: [a]
  def concat([h|t]) when not is_list(h) do
    [h| concat(t)]
  end
  def concat([h|t]) when is_list(h) do
    append(concat(h), concat(t))
  end
end
