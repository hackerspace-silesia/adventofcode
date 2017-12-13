defmodule Layer do
  defstruct [
    key: 0,
    index: 0,
    len: 0,
  ]
end

defmodule TaskThirteen do

  def start do
    data = load_data("input.txt")
    layers = set_layers(data)
    IO.inspect execute(layers), label: "part1"
    IO.inspect execute_part2(layers), label: "part2"
  end

  def load_data(filename) do
    filename
    |> File.stream!
    |> Task.async_stream(fn line ->
      import String

      [key, len] = line
                   |> split(":")
                   |> Enum.map(fn x -> x |> trim |> to_integer end)

      %Layer{key: key, len: len}
    end)
    |> Enum.map(fn {:ok, obj} -> {obj.key, obj} end)
    |> Map.new
  end

  def set_layers(data) do
    {min, max} = data |> Map.keys |> Enum.min_max
    min..max |> Enum.map(fn key -> data[key] || %Layer{key: key} end)
  end

  def execute_part2(layers) do
    try do
      0..90000000
      |> Task.async_stream(fn shift -> execute_and_throw(layers, shift) end)
      |> Stream.run
      nil
    catch
      x when is_integer(x) -> x
    end

  end

  def execute_and_throw(layers, shift) do
    try do
      layers
      |> Stream.map(fn obj ->
        if is_caught(obj, shift), do: throw :fail
      end)
      |> Stream.run

      throw shift
    catch
      :fail -> nil
    end
  end

  def execute(layers, shift \\ 0) do
    layers
    |> Task.async_stream(fn obj -> {obj, is_caught(obj, shift)} end)
    |> Enum.filter(fn {:ok, {_, is_caught}} -> is_caught end)
    |> Enum.reduce(0, fn {:ok, {obj, true}}, acc -> acc + obj.key * obj.len end)
  end

  def is_caught(%Layer{len: 0}, _), do: false
  def is_caught(%Layer{len: 1}, _), do: true
  def is_caught(%Layer{key: key, len: len}, shift) do
    rem(key + shift, len * 2 - 2) == 0
  end

end

TaskThirteen.start
