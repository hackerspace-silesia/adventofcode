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
    IO.inspect get_orphans(data), label: 'root'
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

  defp get_orphans(data) do
    has_parents = data
                  |> Map.values
                  |> Stream.flat_map(fn obj -> obj.nodes end)
                  |> MapSet.new

    set_data = data 
               |> Stream.map(fn {name, _} -> name end)
               |> MapSet.new
  
    MapSet.difference(set_data, has_parents)
  end
end

TaskSeven.start
