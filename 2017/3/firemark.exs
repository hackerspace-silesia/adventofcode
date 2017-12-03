defmodule TaskThree do

  @shifts %{ 
    up: {0, 1},
    down: {0, -1}, 
    left: {-1, 0},
    right: {1, 0},
  }

  @next_directions %{
    up: :left,
    down: :right,
    left: :down,
    right: :up,
  }

  def start do
    value = Enum.at(System.argv(), 0) |> String.to_integer
    {x, y} = find_cordinations(value)
    IO.inspect abs(x) + abs(y), label: "part1"
  end

  defp find_cordinations(value) do
    find_cordinations({0, 0}, 1, 1, 1, :right, value)
  end

  defp find_cordinations(vector, _cell_in_path, cell, _path, _direction, value) when cell >= value do
    vector
  end

  defp find_cordinations({x, y}, cell_in_path, cell, path, present_direction, value) do
    {dx, dy} = @shifts[present_direction]
    vector = {x + dx, y + dy}
    {cell_in_path, path, next_direction} = check_direction(cell_in_path, path, present_direction)
    find_cordinations(vector, cell_in_path, cell + 1, path, next_direction, value) 
  end

  defp check_direction(cell_in_path, path, direction) do
    max_cells_in_path = div(1 + path, 2)
    if cell_in_path >= max_cells_in_path do
      {1, path + 1, @next_directions[direction]}
    else
      {cell_in_path + 1, path, direction}
    end
  end

end

TaskThree.start
