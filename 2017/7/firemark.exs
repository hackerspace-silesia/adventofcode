defmodule DiskNode do
  defstruct [
    name: "",
    weight: 0,
    nodes: [],
  ]
end

defmodule TaskSeven do

  def start do
    data = load_data("input.txt")
    root_name = get_root(data)
    result = get_wrong_weight(data[root_name], data)
    IO.inspect root_name, label: 'root'
    IO.inspect result.diff, label: 'diff'
    IO.inspect result.weight, label: 'weight'
    IO.inspect result.correct_weight, label: 'correct weight'
  end

  defp load_data(filename) do
    {:ok, data} = File.read(filename)

    data
    |> String.split("\n")
    |> Stream.filter(&(&1 != ""))
    |> Stream.map(fn line ->
      {name_weight, nodes} = line
                             |> String.split("->")
                             |> get_values_from_elements

      name_weight = String.trim(name_weight)
      [_, name, raw_weight] = Regex.run(~r/(\w+) \((\d+)\)/, name_weight)
      weight = String.to_integer(raw_weight)

      root_node = %DiskNode{name: name, weight: weight, nodes: nodes}
      {name, root_node}
    end)
    |> Map.new
  end

  defp get_values_from_elements([name_weight, raw_nodes]) do
      nodes = raw_nodes
              |> String.split(",")
              |> Enum.map(&String.trim/1)
      {name_weight, nodes}
  end

  defp get_values_from_elements([name_weight]) do
    {name_weight, []}
  end

  defp get_root(data) do
    has_parents = data
                  |> Map.values
                  |> Stream.flat_map(fn obj -> obj.nodes end)
                  |> MapSet.new

    set_data = data 
               |> Stream.map(fn {name, _} -> name end)
               |> MapSet.new
  
    [root] = set_data
             |> MapSet.difference(has_parents)
             |> Enum.to_list

    root 
  end

  defp get_wrong_weight(disk_node, data) do
    try do
      get_weight!(disk_node, data)
      nil
    catch
      x -> x
    end
  end

  defp get_weight!(%DiskNode{weight: weight, nodes: []}, data) do
    weight
  end

  defp get_weight!(%DiskNode{weight: weight, nodes: nodes}, data) do
    new_weights = Enum.map(nodes, fn name -> get_weight!(data[name], data) end)
    set = MapSet.new(new_weights)
    if MapSet.size(set) != 1 do
      min = Enum.min(new_weights)
      {max, max_index} = get_max_index(new_weights)
      obj = data[Enum.at(nodes, max_index)]
      diff = max - min

      throw(%{
        diff: diff,
        weight: obj.weight,
        correct_weight: obj.weight - diff,
      })
    else 
      Enum.sum(new_weights) + weight
    end
  end

  defp get_max_index([head | tail]) do
    get_max_index(head, 0, 1, tail)
  end

  defp get_max_index([head]) do
    {head, 0}
  end

  defp get_max_index(max_val, max_index, _index, []) do
    {max_val, max_index}
  end

  defp get_max_index(max_val, max_index, index, [head | tail]) do
    if max_val < head do
      get_max_index(head, index, index + 1, tail)
    else
      get_max_index(max_val, max_index, index + 1, tail)
    end
  end

end

TaskSeven.start
