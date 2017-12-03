defmodule TaskTwo do

  def start do
    data = get_data("input_2")
    IO.inspect compute_checksum(data), label: "part 1"
    IO.inspect compute_divisible_checksum(data), label: "part 2"
  end

  defp get_data(filename) do
    {:ok, data} = File.read(filename)

    data
    |> String.split("\n")
    |> Stream.filter(fn row -> row != "" end) 
    |> Stream.map(fn row ->
      row
      |> String.split("\t")
      |> Stream.map(&String.to_integer/1)
    end)
    |> Enum.to_list
  end

  defp compute_checksum(data) do
    max_values = Stream.map(data, &Enum.max/1)
    min_values = Stream.map(data, &Enum.min/1)

    Stream.zip(max_values, min_values)
    |> Stream.map(fn {max, min} -> max - min end)
    |> Enum.sum
  end

  defp compute_divisible_checksum(data) do
    data
    |> Stream.map(&get_value_from_divisible_row/1)
    |> Enum.sum
  end

  defp get_value_from_divisible_row(row) do
    value = row
            |> Stream.flat_map(fn a -> Stream.map(row, fn b -> {a, b} end) end)
            |> Enum.find(fn {a, b} -> a > b && rem(a, b) == 0 end)

    case value do
      nil -> 0
      {a, b} -> div(a, b)
    end
  end

end

TaskTwo.start
