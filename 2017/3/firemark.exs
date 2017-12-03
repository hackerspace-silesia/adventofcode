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

  @neumann_neighbours [
    {0, 1}, {0, -1}, {1, 0}, {-1, 0},
    {1, 1}, {-1, -1}, {1, -1}, {-1, 1}, 
  ]

  def start do
    value = Enum.at(System.argv(), 0) |> String.to_integer
    {{x, y}, computed_value} = find_cordinations(value)
    IO.inspect abs(x) + abs(y), label: "part1"
    IO.inspect computed_value, label: "part2"
  end

  defp find_cordinations(value) do
    computed_values = %{{0, 0} => 1}
    find_cordinations({0, 0}, 1, 1, 1, :right, value, computed_values)
  end

  defp find_cordinations(vector, _cell_in_path, cell, _path, _direction, value, computed_values) when cell >= value do
    {vector, computed_values[vector]}
  end

  defp find_cordinations({x, y}, cell_in_path, cell, path, present_direction, value, computed_values) do
    {dx, dy} = @shifts[present_direction]
    vector = {x + dx, y + dy}

    computed_values = compute_value_from_neighbours(computed_values, vector)
    computed_value = computed_values[vector]
    if computed_value > value do
      {vector, computed_values[vector]}
    else
      {cell_in_path, path, next_direction} = check_direction(cell_in_path, path, present_direction)
      find_cordinations(vector, cell_in_path, cell + 1, path, next_direction, value, computed_values) 
    end
  end

  defp compute_value_from_neighbours(computed_values, vector) do
    {x, y} = vector
    value = @neumann_neighbours
            |> Stream.map(fn {dx, dy} -> computed_values[{x + dx, y + dy}] || 0 end)
            |> Enum.sum

    Map.put(computed_values, vector, value)
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
