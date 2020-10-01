defmodule RobotSimulator do
  @doc """
  Create a Robot Simulator given an initial direction and position.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec create(direction :: atom, position :: {integer, integer}) :: any
  def create(direction \\ :north, position \\ {0, 0})  do
    robot = {direction, position}
    validate_robot(robot)
  end

  defp validate_robot({direction, position}) do
     direction = validate_direction(direction)

     position = validate_position(position)
     case {direction, position} do
      {{:error, msg}, _} -> {:error, msg}
      {_, {:error, msg}} -> {:error, msg}
      robot -> robot
     end
  end

  def validate_direction(direction) when direction in [:north, :east, :south, :west], do: direction
  def validate_direction(_), do: {:error, "invalid direction"}

  def validate_position({x, y}) when is_integer(x) and is_integer(y), do: {x, y}
  def validate_position(_), do: {:error, "invalid position"}

  def validate_instruction(instruction) when instruction in [?L, ?R, ?A], do: instruction
  def validate_instruction(_), do: {:error, "invalid instruction"}


  @doc """
  Simulate the robot's movement given a string of instructions.

  Valid instructions are: "R" (turn right), "L", (turn left), and "A" (advance)
  """
  @spec simulate(robot :: any, instructions :: String.t()) :: any
  def simulate(robot, instructions) when is_binary(instructions) do
    instructions
      |> String.to_charlist
      |> Enum.map(&validate_instruction/1)
      |> do_simulate(robot)
  end

  def do_simulate([], robot), do: robot
  def do_simulate([{:error, msg}|_], _), do: {:error, msg}
  def do_simulate([instruction|rest], robot) do
    updated_robot = case instruction do
      ?R -> turn_right(robot)
      ?L -> turn_left(robot)
      ?A -> move_advance(robot)
    end
    do_simulate(rest, updated_robot)
  end

  defp turn_left({direction, position}) do
    new_direction = case direction do
      :north -> :west
      :west -> :south
      :south -> :east
      :east -> :north;
    end
    {new_direction, position}
  end

  defp turn_right({direction, position}) do
    new_direction = case direction do
      :north -> :east
      :east -> :south
      :south -> :west
      :west -> :north
    end
    {new_direction, position}
  end

  defp move_advance({direction, {x, y}}) do
    new_position = case direction do
      :north -> {x, y + 1}
      :east -> {x + 1, y}
      :south -> {x, y - 1}
      :west -> {x - 1, y}
    end
    {direction, new_position}
  end


  @doc """
  Return the robot's direction.

  Valid directions are: `:north`, `:east`, `:south`, `:west`
  """
  @spec direction(robot :: any) :: atom
  def direction({direction, _}) do
    direction
  end

  @doc """
  Return the robot's position.
  """
  @spec position(robot :: any) :: {integer, integer}
  def position({_, position}) do
    position
  end
end
