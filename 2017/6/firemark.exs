defmodule TaskSix do

  def start do
    data = get_data("input.txt")
    {count, loop_size} = banking(data)

    IO.inspect count, label: "count"
    IO.inspect loop_size, label: "loop size"
  end

  defp get_data(filename) do
    {:ok, data} = File.read(filename)

    data
    |> String.split("\t")
    |> Stream.map(&String.trim/1)
    |> Stream.map(&String.to_integer/1)
    |> Enum.to_list
  end

  defp banking(data) do
    banking(1, data, %{data => 0})
  end

  defp banking(count, data, history) do
    {value, index} = find_max_index(data)
    new_data = List.replace_at(data, index, 0)
    new_data = redistribute(value, index, new_data)

    case Map.get(history, new_data) do
      nil ->
        history = Map.put(history, new_data, count)
        banking(count + 1, new_data, history)
      last_data_count -> {count, count - last_data_count}
    end

  end

  defp redistribute(0, _index, data) do
    data
  end

  defp redistribute(value, index, data) do
    index = rem(index + 1, length(data))
    data = List.update_at(data, index, &(&1 + 1)) 
    redistribute(value - 1, index, data)
  end

  defp find_max_index(data) do
    find_max_index(0, nil, 0, data)
  end

  defp find_max_index(max_val, max_index, index, [next_val | data]) do
    if max_val < next_val do
      find_max_index(next_val, index, index + 1, data)
    else
      find_max_index(max_val, max_index, index + 1, data)
    end
  end

  defp find_max_index(max_val, max_index, _index,  []) do
    {max_val, max_index}
  end
end

TaskSix.start
