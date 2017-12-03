defmodule TaskOne do
  def start() do
    {:ok, string_data} = File.read("input_1")
    data = get_data(string_data)
    sum = compute_sum(data)
    IO.puts sum
  end

  defp get_data(string_data) do
    String.codepoints(string_data)
    |> Enum.filter(fn(char) -> char != "\n" end)
    |> Enum.map(&String.to_integer/1)
  end

  defp compute_sum([digit | tail]) do
    compute_sum(0, digit, digit, tail)
  end

  defp compute_sum(sum, first_digit, prev_digit, [digit | tail]) do
    add_if_is_equal(sum, digit, prev_digit)
    |> compute_sum(first_digit, digit, tail)
  end

  defp compute_sum(sum, first_digit, prev_digit, []) do
    add_if_is_equal(sum, first_digit, prev_digit)
  end

  defp add_if_is_equal(sum, a, b) do
    if a == b, do: sum + a, else: sum
  end
end

TaskOne.start
