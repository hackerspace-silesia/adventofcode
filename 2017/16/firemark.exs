defmodule TaskSixteen do

  def start do
    data = load_data("input.txt")
    programs = get_programs()
    IO.inspect execute(programs, data), label: 'part1'
    IO.inspect execute_part2(programs, data), label: 'part1'
  end

  defp get_programs do
    Enum.to_list(?a..?p)
  end

  defp load_data(filename) do
    {:ok, data} = File.read(filename)

    data
    |> String.split(",")
    |> Enum.map(fn action -> action |> String.trim |> String.to_charlist end)
  end

  defp check_cycle(input, data) do
    stream = Stream.iterate({input, 1}, fn {prog, c} ->
      prog = execute(prog, data)
      if prog == input do
        throw c
      else
        {prog, c + 1}
      end
    end) 

    try do
      Stream.run(stream)
    catch
      count -> count
    end
  end


  defp execute_part2(input, data) do
    cycle = check_cycle(input, data)
    count = rem(1000000000, cycle)
    IO.inspect cycle, label: "cycle"
    IO.inspect count, label: "count"
    Enum.reduce(1..count, input, fn _, acc -> execute(acc, data) end)
  end

  defp execute(input, data) do
    Enum.reduce(data, input, &run_action/2)
  end

  defp run_action([char | tail], input) do
    run_action(char, to_string(tail), input)
  end

  defp run_action(?s, args, input) do
    size = length(input)
    shift = args |> String.to_integer |> rem(size)
    Enum.slice(input ++ input, size - shift, size)
  end

  defp run_action(?x, args, input) do
    [[_ | data ]] = Regex.scan(~r/(\d+)\/(\d+)/, args)
    [a, b] = Enum.map(data, fn x -> Enum.at(input, String.to_integer(x)) end)

    swap_elements(input, a, b, [])
  end

  defp run_action(?p, args, input) do
    [[_ | data ]] = Regex.scan(~r/(\w+)\/(\w+)/, args)
    [a, b] = data |> Enum.join("") |> String.to_charlist

    swap_elements(input, a, b, [])
  end

  defp swap_elements([], _a, _b, output) do
    Enum.reverse(output)
  end

  defp swap_elements([char | input], a, b, output) do
    char = cond do
      char == a -> b
      char == b -> a
      true -> char
    end

    swap_elements(input, a, b, [char | output])
  end

end

TaskSixteen.start
