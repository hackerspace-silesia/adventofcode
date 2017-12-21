defmodule TaskNineteen do

  def start do
    map = load_map("input.txt")
    start = get_start(map)
    {stack, steps} = step(start, :down, map)
    IO.inspect stack, label: "letters"
    IO.inspect steps, label: "steps"
  end

  defp load_map(filename) do
    filename
    |> File.stream!
    |> Stream.with_index(0)
    |> Enum.flat_map(fn {line, y} ->
      line
      |> to_charlist
      |> Stream.with_index(0)
      |> Stream.filter(fn {char, _} -> char not in '\n\s' end)
      |> Enum.map(fn {char, x} -> {{x, y}, char} end)
    end)
    |> Map.new
  end

  defp get_start(map) do
    [x] = Stream.iterate(0, fn x -> x + 1 end)
          |> Stream.filter(fn x -> map[{x, 0}] == ?| end)
          |> Enum.take(1)
    {x, 0}
  end

  defp step(cord, dir, map, stack \\ [], steps \\ 0) do
    case map[cord] do
      nil -> {stack |> Enum.reverse |> to_string, steps}
      ?+ -> 
        {x, y} = cord
        dir = case dir do
          d when d in [:down, :up] ->
            if map[{x - 1, y}] != nil, do: :left, else: :right
          d when d in [:left, :right] ->
            if map[{x, y + 1}] != nil, do: :down, else: :up
        end
        cord |> move(dir) |> step(dir, map, stack, steps + 1)
      x when x in '-|' -> cord |> move(dir) |> step(dir, map, stack, steps + 1)
      x -> cord |> move(dir) |> step(dir, map, [x | stack], steps + 1)
    end
  end

  defp move({x, y}, :down), do: {x, y + 1}
  defp move({x, y}, :up), do: {x, y - 1}
  defp move({x, y}, :right), do: {x + 1, y}
  defp move({x, y}, :left), do: {x - 1, y}
end

TaskNineteen.start
