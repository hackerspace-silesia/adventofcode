defmodule TaskTen do

  def start do
    filename = "input.txt"
    IO.inspect execute_part1(filename), label: "result part1"
    IO.inspect execute_part2(filename), label: "result part2"
  end

  defp load_data(filename) do
    {:ok, data} = File.read(filename)

    data
    |> String.split(",")
    |> Enum.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end

  defp execute_part2(filename) do
    use Bitwise
    {:ok, data} = File.read(filename)
    data = data |> String.trim |> String.to_charlist
    data = data ++ [17, 31, 73, 47, 23]

    first_list = Enum.to_list(0..255)
    {result, _, _} = Enum.reduce(
      1..64, 
      {first_list, 0, 0},
      fn _, list -> execute(data, list) end
    )

    result  
    |> Stream.chunk(16)
    |> Task.async_stream(fn vals -> 
      vals
      |> Enum.reduce(&Bitwise.bxor/2)
      |> Integer.to_charlist(16)
      |> to_string
      |> String.downcase
    end)
    |> Stream.map(fn {:ok, chunk} -> chunk end)
    |> Enum.join("")
  end

  defp execute_part1(filename) do
    data = load_data(filename)
    list = Enum.to_list(0..255)
    {result, _, _} = execute(data, list)
    [a, b] = Enum.take(result, 2)
    a * b
  end

  defp execute(data, {list, index, skip_size}) do
    execute(data, list, index, skip_size)
  end

  defp execute(data, list, index \\ 0, skip_size \\ 0) do
    Enum.reduce(data, {list, index, skip_size}, &reverse/2)
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
