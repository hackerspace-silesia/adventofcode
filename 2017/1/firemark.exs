defmodule TaskOne do
  def start() do
    {:ok, string_data} = File.read("input_1")
    data = get_data(string_data)
    IO.inspect(compute_sum(data, 1), label: "part1")
    IO.inspect(compute_sum(data, div(length(data), 2)), label: "part2")
  end

  defp get_data(string_data) do
    string_data
    |> String.codepoints
    |> Enum.filter(fn(char) -> char != "\n" end)
    |> Enum.map(&String.to_integer/1)
  end

  defp compute_sum(data, shift) do
    compute_sum(0, length(data) - 1, shift, data)
  end

  defp compute_sum(sum, 0, shift, data) do
    add_if_is_equal(sum, 0, shift, data)
  end

  defp compute_sum(sum, index, shift, data) do
    sum
    |> add_if_is_equal(index, shift, data)
    |> compute_sum(index - 1, shift, data)
  end

  defp add_if_is_equal(sum, index, shift, data) do
    shifted_index = rem(index + shift, length(data))
    a = Enum.at(data, index) 
    b = Enum.at(data, shifted_index)
    if a == b, do: sum + a, else: sum
  end
end

TaskOne.start
