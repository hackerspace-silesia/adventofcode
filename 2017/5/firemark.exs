defmodule TaskFive do

  def start do
    data = get_data("input.txt")
    IO.inspect count_jumps(data, &(&1 + 1)), label: "part1"
    IO.inspect count_jumps(data, &part2_func/1), label: "part2"
  end

  defp part2_func(jumps) when jumps >= 3, do: jumps - 1
  defp part2_func(jumps), do: jumps + 1

  defp get_data(filename) do
    {:ok, raw_data} = File.read(filename)
    splited_data = String.split(raw_data, "\n")

    splited_data
    |> Stream.filter(&(&1 != ""))
    |> Stream.map(&String.to_integer/1)
    |> Stream.with_index(0)
    |> Stream.map(fn {k, v} -> {v, k} end)
    |> Map.new
  end

  defp count_jumps(data, jumps_func) do
    count_jumps(0, 0, jumps_func, data)
  end

  defp count_jumps(count, index, jumps_func, data) do
    case data[index] do
      nil -> count
      jumps ->
        new_jumps = jumps_func.(jumps)
        updated_data = Map.replace(data, index, new_jumps)
        count_jumps(count + 1, index + jumps, jumps_func, updated_data)
    end
  end
end

TaskFive.start
