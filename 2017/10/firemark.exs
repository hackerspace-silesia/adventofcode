defmodule TaskTen do

  def start do
    data = load_data("input.txt")
    IO.inspect execute_part1(data), label: "result part1"
    IO.inspect execute_part2(data), label: "result part2"
  end

  defp load_data(filename) do
    {:ok, data} = File.read(filename)

    data
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  defp execute_part2(data) do

  end

  defp execute_part1(data) do
    list = Enum.to_list(0..255)
    {list, _, _} = execute(data, list)
    [a, b] = Enum.take(result, 2)
    a * b
  end

  defp execute(data, list) do
    Enum.reduce(data, {list, 0, 0}, &reverse/2)
    list
  end

  defp reverse(reverse_size, {list, index, skip_size}) do
    size = Enum.count(list)
    last_index = index + reverse_size
    new_index = rem(last_index + skip_size, size)

    list = list ++ list  # double to avoid problem with cycle
           |> Enum.reverse_slice(index, reverse_size)
           |> warp(size, last_index)

    {list, new_index, skip_size + 1}
  end

  defp warp(list, size, last_index) do
    shift = Enum.max([0, last_index - size])
    left = Enum.slice(list, size, shift)
    right = Enum.slice(list, shift, size - shift)
    left ++ right
  end
end

TaskTen.start
