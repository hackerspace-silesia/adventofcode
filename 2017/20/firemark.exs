defmodule Particle do
  @empty_vec {0, 0, 0}
  defstruct [index: 0, p: @empty_vec, v: @empty_vec, a: @empty_vec]

  def step(%Particle{index: index, p: p, v: v, a: a}) do
    {p0, p1, p2} = p
    {v0, v1, v2} = v
    {a0, a1, a2} = a

    v = {v0 + a0, v1 + a1, v2 + a2}
    p = {p0 + v0, p1 + v1, p2 + v2}
    %Particle{index: index, p: p, v: v, a: a}
  end

  def distance(particle), do: vec_value(particle.p)
  def acceleration(particle), do: vec_value(particle.a)
  defp vec_value({x, y, z}), do: abs(x) + abs(y) + abs(z)

end

defmodule TaskTwenty do
  def start do
    data = load_data("input.txt")
    IO.inspect find_closest(data), label: "the closest particle"
  end

  defp load_data(filename) do
    re_line = ~r/^p=<(-?\d+),(-?\d+),(-?\d+)>, v=<(-?\d+),(-?\d+),(-?\d+)>, a=<(-?\d+),(-?\d+),(-?\d+)>$/
    filename
    |> File.stream!
    |> Stream.with_index(0)
    |> Task.async_stream(fn {line, index} ->
      [_, p0, p1, p2, v0, v1, v2, a0, a1, a2] = Regex.run(re_line, line)

      p = raw_vec_to_int_vec({p0, p1, p2}) 
      v = raw_vec_to_int_vec({v0, v1, v2}) 
      a = raw_vec_to_int_vec({a0, a1, a2}) 

      %Particle{index: index, p: p, v: v, a: a}
    end)
    |> Enum.map(fn {:ok, particle} -> particle end)
  end

  defp raw_vec_to_int_vec({x, y, z}) do
    x = String.to_integer(x)
    y = String.to_integer(y)
    z = String.to_integer(z)
    {x, y, z}
  end

  defp find_all_collisions([], count \\ 0) do
    count
  end

  defp find_all_collisions(data, count \\ 0) do
    {data, _} = Enum.reduce(data, {%{}, %{}}, fn data, new ->
      data,
    end)

    find_all_colisions(Enum.map(data, &Particle.step/1), count + 1)
  end

  defp find_closest(data) do
    data = Enum.reduce(0..20000, data, fn _i, data ->
      # debug
      #particle = Enum.min_by(data, &Particle.distance/1)
      # IO.inspect particle.index, label: "iterate #{_i}"

      Enum.map(data, &Particle.step/1)
    end)
    particle = Enum.min_by(data, &Particle.distance/1)
    particle.index
  end
end

TaskTwenty.start
