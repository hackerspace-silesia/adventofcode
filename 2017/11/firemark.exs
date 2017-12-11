defmodule TaskEleven do

  def start do
    data = load_data("input.txt")
    {max_steps, cords} = get_cordinates(data)
    steps = get_steps_count(cords)
    IO.inspect steps, label: "steps"
    IO.inspect max_steps, label: "max steps"
  end

  def load_data(filename) do
    {:ok, data} = File.read(filename)

    data
    |> String.split(",")
    |> Enum.map(&String.trim/1)
  end

  def get_cordinates(data) do
    Enum.reduce(data, {0, {0, 0, 0}}, fn dir, {max, cords} -> 
      cords = step(dir, cords) 
      max = Enum.max([max, get_steps_count(cords)])
      {max, cords}
    end)
  end

  def get_steps_count({x, y, z}) do
    [x, y, z] |> Enum.map(&abs/1) |> Enum.sum |> div(2)
  end

  # https://www.redblobgames.com/grids/hexagons/#coordinates-cube
  def step("n", {x, y, z}), do: {x, y + 1, z - 1}
  def step("s", {x, y, z}), do: {x, y - 1, z + 1}
  def step("ne", {x, y, z}), do: {x + 1, y, z - 1}
  def step("sw", {x, y, z}), do: {x - 1, y, z + 1}
  def step("nw", {x, y, z}), do: {x - 1, y + 1, z}
  def step("se", {x, y, z}), do: {x + 1, y - 1, z}

end

TaskEleven.start

