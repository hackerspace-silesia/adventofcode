defmodule TaskFifteen do
  @a_prod 16807
  @b_prod 48271
  @socek 2147483647

  def start do
    argv = System.argv
    [a, b] = argv |> Enum.take(2) |> Enum.map(&String.to_integer/1)

    IO.inspect count_part1(a, b), label: 'count part1'
    IO.inspect count_part2(a, b), label: 'count part2'
  end

  defp count_part1(a, b) do
    {_, _, count} = Enum.reduce(
      1..40000000,
      {a, b, 0},
      fn _, {a, b, count} -> step_part1(a, b, count) end
    )
    count
  end

  defp count_part2(a, b) do
    {_, _, count} = Enum.reduce(
      1..5000000,
      {a, b, 0},
      fn _, {a, b, count} -> step_part2(a, b, count) end
    )
    count
  end

  defp step_part1(a, b, count) do
    a = rem(a * @a_prod, @socek)
    b = rem(b * @b_prod, @socek)
    check(a, b, count)
  end

  defp step_part2(a, b, count) do
    use Bitwise
    a = seek_val(a, @a_prod, 4)
    b = seek_val(b, @b_prod, 8)
    check(a, b, count)
  end

  defp seek_val(x, prod, multiples_by) do
    x = rem(x * prod, @socek)
    if rem(x, multiples_by) == 0 do
      x
    else
      seek_val(x, prod, multiples_by)
    end
  end

  defp check(a, b, count) do
    use Bitwise
    pred = (a &&& 0xFFFF) == (b &&& 0xFFFF)
    if pred, do: {a, b, count + 1}, else: {a, b, count}
  end

end

TaskFifteen.start
