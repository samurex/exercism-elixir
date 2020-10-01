defmodule LinkedList do
  @opaque t :: tuple()
  import Kernel, except: [length: 1]
  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {nil, nil}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push({nil, nil}, elem) do
    {elem, LinkedList.new}
  end

  def push({head, tail}, elem) do
    {elem, {head, tail}}
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec length(t) :: non_neg_integer()
  def length({nil, nil}), do: 0
  def length({_, tail}), do: 1 + length(tail)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({nil, nil}), do: true
  def empty?({_, _}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek({nil, nil}) do
    {:error, :empty_list}
  end
  def peek({head, _}) do
    {:ok, head}
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail({nil, nil}), do: {:error, :empty_list}
  def tail({_, tail}) do
    {:ok, tail}
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop({nil, nil}), do: {:error, :empty_list}
  def pop({head, tail}) do {:ok, head, tail}
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list([]), do: LinkedList.new
  def from_list([h|t]) do
    list = from_list(t)
    LinkedList.push(list, h)
  end

  # def from_list(list), do: do_from_list(list, LinkedList.new)

  # def do_from_list([], acc), do: acc
  # def do_from_list([h|t], acc) do
  #   do_from_list(t, LinkedList.push(acc, h))
  # end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list({nil, nil}), do: []
  def to_list({head, tail}) do
    [ head | to_list(tail) ]
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    do_reverse(list, LinkedList.new)
  end
  def do_reverse({nil, nil}, acc), do: acc
  def do_reverse({h, t}, acc) do
    do_reverse(t, LinkedList.push(acc, h))
  end
end
