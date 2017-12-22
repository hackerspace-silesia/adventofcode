defmodule TaskTwentyTwo do

  def start do
    map = load_map("input.txt")

    IO.inspect execute(map, 10000, &part1/1), label: "part1"
    IO.inspect execute(map, 10000000, &part2/1), label: "part2"
  end

  def load_map(filename) do
    filename
    |> File.stream!
    |> Stream.with_index(0)
    |> Enum.flat_map(fn {line, y} ->
      line = String.trim(line)
      s = String.length(line) / 2 |> Float.floor |> round

      line
      |> String.to_charlist
      |> Stream.with_index(0)
      |> Enum.filter(fn {char, _} -> char != ?. end)
      |> Enum.map(fn {char, x} -> {{x - s, y - s}, char} end)
    end)
    |> Map.new
  end

  def execute(map, max_steps, func) do
    range = 1..max_steps
    initial = {map, {0, 0}, :up, 0}
    {_map, _cord, _dir, score} = Enum.reduce(range, initial, fn _, o -> func.(o) end)

    #debug map, cord
    score
  end

  defp part1({map, cord, dir, score}) do
    case map[cord] || ?. do
      ?. ->
        dir = left(dir)
        {Map.put(map, cord, ?#), move(cord, dir), dir, score + 1}
      ?# -> 
        dir = right(dir)
        {Map.delete(map, cord), move(cord, dir), dir, score}
    end
  end

  defp part2({map, cord, dir, score}) do
    case map[cord] || ?. do
      ?. ->
        dir = left(dir)
        {Map.put(map, cord, ?W), move(cord, dir), dir, score}
      ?W ->
        {Map.put(map, cord, ?#), move(cord, dir), dir, score + 1}
      ?# -> 
        dir = right(dir)
        {Map.put(map, cord, ?F), move(cord, dir), dir, score}
      ?F -> 
        dir = reverse(dir)
        {Map.delete(map, cord), move(cord, dir), dir, score}
    end
  end

  defp debug(map, cord) do
    size = 25
    IO.puts Enum.map(-size..size, fn y ->
      Enum.map(-size..size, fn x ->
        c = {x, y}
        val = map[{x, y}] || ?.
        if cord == c do 
          '\e[91m' ++ [val] ++ '\e[0m'
        else
          val
        end
      end) |> to_string
    end) |> Enum.join("\n")
    IO.puts ""

  end

  defp reverse(dir) do
    case dir do
      :up -> :down
      :down -> :up
      :left -> :right
      :right -> :left
    end
  end

  defp left(dir) do
    case dir do
      :up -> :left
      :left -> :down
      :down -> :right
      :right -> :up
    end
  end

  defp right(dir) do
    case dir do
      :up -> :right
      :right -> :down
      :down -> :left
      :left -> :up
    end
  end

  defp move({x, y}, dir) do
    case dir do
      :up -> {x, y - 1}
      :down -> {x, y + 1}
      :left -> {x - 1, y}
      :right -> {x + 1, y}
    end
  end

end

TaskTwentyTwo.start
