defmodule Tournament do
  @doc """
  Given `input` lines representing two teams and whether the first of them won,
  lost, or reached a draw, separated by semicolons, calculate the statistics
  for each team's number of games played, won, drawn, lost, and total points
  for the season, and return a nicely-formatted string table.

  A win earns a team 3 points, a draw earns 1 point, and a loss earns nothing.

  Order the outcome by most total points for the season, and settle ties by
  listing the teams in alphabetical order.
  """
  @spec tally(input :: list(String.t())) :: String.t()
  def tally(input) do
    input
      |> parse_input
      |> transform_data
      |> print_table

  end

  defp parse_input(input) do
    input
      |> Enum.map(&String.split(&1, ";"))
      |> Enum.filter(&(Enum.count(&1) == 3))
      |> Enum.filter(fn [_, _, result] -> result in ["win", "loss", "draw"] end)
      |> Enum.flat_map(fn [team1, team2, result] ->
        [
          [team1, result],
          [team2, mirror_result(result)]
        ]
      end)
  end

  defp mirror_result("win"), do: "loss"
  defp mirror_result("loss"), do: "win"
  defp mirror_result("draw"), do: "draw"


  defp transform_data(input) do
    input
      |> Enum.reduce(%{}, fn [team, result], acc ->
        acc
          |> Map.update(team, update_row(create_empty(), result),
            fn row -> update_row(row, result)
          end)
      end)
      |> Enum.map(fn {team, results} -> Map.put(results, "team", team) end)
      |> Enum.sort(fn r1, r2 -> r1["P"] >= r2["P"] && r1["team"] < r2["team"] end)
  end

  defp create_empty() do
    %{"MP" => 0, "W" => 0, "D" => 0, "L" => 0, "P" => 0}
  end

  defp update_row(row, result) do
    case result do
      "win" ->
        row
          |> Map.update("W", 1,  &(&1 + 1))
          |> Map.update("P", 1, &(&1 + 3))
          |> Map.update("MP", 1, &(&1 + 1))
      "loss" ->
        row
          |> Map.update("L", 1, &(&1 + 1))
          |> Map.update("MP", 1, &(&1 + 1))

      "draw" ->
        row
          |> Map.update("D", 1, &(&1 + 1))
          |> Map.update("P", 1, &(&1 + 1))
          |> Map.update("MP", 1, &(&1 + 1))
    end
  end


  defp print_row(%{"team" => team, "MP" => mp, "W" => w, "D" => d, "L" => l, "P" => p}) do
    [mp, w, d, l, p]
      |> Enum.reduce("#{String.pad_trailing(team, 31)}|", fn
        n, acc when is_binary(n) -> acc <> String.pad_leading(n, 3) <> " |"
        n, acc ->  acc <> String.pad_leading(to_string(n), 3) <> " |"
      end)
      |> String.trim(" |")
  end

  defp print_table(map) do
    header = print_row(
      %{"team" => "Team", "MP" => "MP", "W" => "W", "D" => "D", "L" => "L", "P" => "P"}
    )
    rows = map
      |> Enum.map(&print_row/1)

    [header|rows]
      |> Enum.join("\n")
  end
end
