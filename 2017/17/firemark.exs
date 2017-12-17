defmodule TaskSeventeen do
  def start do
    input = System.argv |> Enum.at(0) |> String.to_integer
    IO.inspect spinlock_part1(input), label: "part1"
    IO.inspect spinlock_part2(input), label: "part2"
  end

  def spinlock_part1(forward_steps) do
    range = 1..2017
    {last_index, output} = Enum.reduce(range, {0, [0]}, fn count, {index, o} ->
      index = rem(index + forward_steps, count) + 1
      left = Enum.slice(o, 0, index)
      right = Enum.slice(o, index, count - index) 
      {index, left ++ [count] ++ right}
    end)

    Enum.at(output, last_index + 1)
  end

  def spinlock_part2(forward_steps) do
    range = 1..50000000
    {_, value} = Enum.reduce(range, {0, 0}, fn count, {index, next_val} ->
      index = rem(index + forward_steps, count) + 1
      if index == 1 do
        {index, count}
      else
        {index, next_val}
      end
    end)

    value
  end
end

TaskSeventeen.start
