defmodule Matrix do
  defstruct matrix: nil, rows: 0, cols: 0

  def new(rows, cols, list) when length(list) == cols * rows  do
    matrix = list
      |> Enum.with_index
      |> Enum.map(fn {el, i} ->
        {div(i, rows), rem(i, rows), el}
      end)

    %Matrix{matrix: matrix, rows: rows, cols: cols}
  end

  def set(%Matrix{matrix: matrix, rows: rows, cols: cols}, i, j, value) do
    updated = matrix
      |> Enum.map(fn
        {^i, ^j, _} -> {i, j, value}
        x -> x
      end)
      %Matrix{matrix: updated, rows: rows, cols: cols}
  end

  @doc """
  Convert an `input` string, with rows separated by newlines and values
  separated by single spaces, into a `Matrix` struct.
  """
  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    list = input
      |> String.split("\n")
      |> Enum.map(&String.split/1)
      |> Enum.map(fn row -> Enum.map(row, &String.to_integer(&1)) end)

    rows = length(list)
    [first|_] = list
    cols = length(first || [])

    Matrix.new(rows, cols, List.flatten(list))
  end

  @doc """
  Write the `matrix` out as a string, with rows separated by newlines and
  values separated by single spaces.
  """
  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(%Matrix{rows: rows} = matrix) do
    matrix.matrix
      |> Enum.reduce("", fn
          {i, j, v}, acc when j == rows - 1 and i != rows - 1 -> acc <>  " " <> Integer.to_string(v) <> "\n"
          {_, j, v}, acc when j == 0 -> acc <> Integer.to_string(v)
          {_, _, v}, acc -> acc <> " " <> Integer.to_string(v)
      end)
  end

  @doc """
  Given a `matrix`, return its rows as a list of lists of integers.
  """
  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(%Matrix{} = matrix) do
    matrix.matrix
      |> Enum.group_by(fn {i, _, _} -> i end)
      |> Map.values
      |> Enum.map(fn row -> Enum.map(row, fn {_, _, v} -> v end) end)
  end

  @doc """
  Given a `matrix` and `index`, return the row at `index`.
  """
  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(%Matrix{} = matrix, index) do
    matrix.matrix
      |> Enum.filter(&match?({^index, _, _}, &1))
      |> Enum.map(fn {_, _, v} -> v end)
  end

  @doc """
  Given a `matrix`, return its columns as a list of lists of integers.
  """
  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(%Matrix{} = matrix) do
    matrix.matrix
    |> Enum.group_by(fn {_, j, _} -> j end)
    |> Map.values
    |> Enum.map(fn row -> Enum.map(row, fn {_, _, v} -> v end) end)
  end

  @doc """
  Given a `matrix` and `index`, return the column at `index`.
  """
  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    matrix.matrix
      |> Enum.filter(&match?({_, ^index, _}, &1))
      |> Enum.map(fn {_, _, v} -> v end)
  end
end
