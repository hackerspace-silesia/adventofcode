defmodule TaskFourteen do

  def start do
    input = Enum.at(System.argv, 0)
    knots = compute_knots(input)
    IO.puts(
      knots |> Enum.map(&to_string/1) |> Enum.join("\n")
    )
    IO.inspect count_used_bins(knots), label: "Used fields"
    count = group_grid(knots)
    IO.inspect count, label: "count groups"
    
  end

  defp group_grid(knots) do
    grid = knots_to_grid(knots)
    find_groups(grid, 0)
  end

  defp find_groups(grid, count) when grid == %{}, do: count
  defp find_groups(grid, count) do
    [p] = grid |> Map.keys |> Enum.take(1)
    find_groups(find_group(grid, p), count + 1)
  end

  defp find_group(grid, p) do
    {x, y} = p
    {el, grid} = Map.pop(grid, p)
    if is_nil(el) do
      grid
    else
      grid 
      |> find_group({x + 1, y})
      |> find_group({x, y + 1})
      |> find_group({x - 1, y})
      |> find_group({x, y - 1})
    end
  end

  defp knots_to_grid(knots) do
    knots
    |> Stream.with_index(0)
    |> Stream.flat_map(fn {knot, y} ->
      knot
      |> Stream.with_index(0)
      |> Enum.filter(fn {char, _} -> char == ?1 end) 
      |> Enum.map(fn {char, x} -> {{x, y}, char} end) 
    end)
    |> Map.new
  end

  defp count_used_bins(knots) do
    knots
    |> Task.async_stream(fn knot ->
      knot
      |> Enum.filter(fn char -> char == ?1 end)
      |> Enum.count
    end)
    |> Enum.reduce(0, fn {:ok, count}, acc -> count + acc end)
  end

  defp compute_knots(input) do
    0..127
    |> Task.async_stream(fn num -> knot(input, num) end)
    |> Enum.map(fn {:ok, knot} -> knot end)
  end

  defp knot(input, num) do
    use Bitwise
    data = String.to_charlist("#{input}-#{num}")
    data = data ++ [17, 31, 73, 47, 23]

    first_list = Enum.to_list(0..255)
    {result, _, _} = Enum.reduce(
      1..64, 
      {first_list, 0, 0},
      fn _, obj -> knot_data(data, obj) end
    )

    result  
    |> Stream.chunk(16)
    |> Task.async_stream(fn vals -> 
      chunk = Enum.reduce(vals, &Bitwise.bxor/2)
      [num] = :io_lib.format("~.2B", [chunk])
      to_string(num) |> String.rjust(8, ?0) |> String.to_charlist # fuck u Elixir
    end)
    |> Enum.flat_map(fn {:ok, num} -> num end)
  end

  defp knot_data(data, {list, index, skip_size}) do
    knot_data(data, list, index, skip_size)
  end

  defp knot_data(data, list, index \\ 0, skip_size \\ 0) do
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
    if shift > 0 do
      left = Enum.slice(list, size, shift)
      right = Enum.slice(list, shift, size - shift)
      left ++ right
    else
      Enum.take(list, size)
    end
  end

end

TaskFourteen.start
