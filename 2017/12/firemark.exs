defmodule TaskTwelve do

  def start do
    data = load_data("input.txt")
    set = get_group(data, 0)
    count = count_groups(data)

    IO.inspect MapSet.size(set), label: "size of group"
    IO.inspect count, label: "groups count"
    
  end

  defp load_data(filename) do
    import String

    filename
    |> File.stream!
    |> Task.async_stream(fn line ->
      [id, ids] = line |> trim |> split(" <-> ")

      id = to_integer(id)
      ids = ids
            |> split(",")
            |> Enum.map(fn num -> num |> trim |> to_integer end)
            |> MapSet.new
      {id, ids}
    end)
    |> Enum.map(fn {:ok, obj} -> obj end)
    |> Map.new
  end

  defp count_groups(data) do
    count_groups(data, 0)
  end

  defp count_groups(data, count) when map_size(data) == 0 do
    count
  end

  defp count_groups(data, count) do
    [{id, _ }] = Enum.take(data, 1)
    set = get_group(data, id)
    {_, data} = Map.split(data, MapSet.to_list(set))
    count_groups(data, count + 1)
  end

  defp get_group(data, id) do
    set = data[id]
    get_group(data, set, set)
  end

  defp get_group(data, ids, group) do
    new_set = get_new_set(data, ids)
    if MapSet.subset?(new_set, group) do
      group
    else
      group = MapSet.union(new_set, group)
      get_group(data, new_set, group)
    end
  end

  defp get_new_set(data, ids) do
    ids
    |> Task.async_stream(fn set_id -> data[set_id] end)
    |> Enum.reduce(
      MapSet.new,
      fn {:ok, set}, new_set -> MapSet.union(new_set, set) end
    )
  end
end

TaskTwelve.start
