defmodule Image do

  def transform(str) do
    String.split(str, "/")
  end

  def at(img, x, y) do
    img |> Enum.at(y) |> String.at(x)
  end

  def flip_x(img) do
    Enum.map(img, &String.reverse/1)
  end

  def flip_y(img) do
    Enum.reverse(img)
  end

  def rorate_270(img) do
    n = length(img) - 1
    Enum.map(0..n, fn y ->
      Enum.map(0..n, fn x -> at(img, y, x) end) |> Enum.join("")
    end)
  end

  def rorate_90(img) do
    n = length(img) - 1
    Enum.map(0..n, fn y ->
      Enum.map(n..0, fn x -> at(img, y, x) end) |> Enum.join("")
    end)
  end

  def rorate_180(img) do
    img |> flip_x |> flip_y
  end

  def debug do
    import Enum
    key = transform(".#./..#/###")

    IO.puts join(key, "\n")
    IO.puts ""
    IO.puts flip_x(key) |> join("\n")
    IO.puts ""
    IO.puts flip_y(key) |> join("\n")
    IO.puts ""
    IO.puts rorate_90(key) |> join("\n")
    IO.puts ""
    IO.puts rorate_270(key) |> join("\n")
    IO.puts ""
    IO.puts rorate_180(key) |> join("\n")
    IO.puts ""
  end

  def slice(img, x_range, y_range) do
    img 
    |> Enum.slice(y_range)
    |> Enum.map(&String.slice(&1, x_range))
  end

end

defmodule TaskTwentyOne do
  def start do
    #Image.debug
    data = load_data("input.txt")
    data = generate_missing(data)

    IO.inspect execute(data, 18), label: "count pixels final"
  end

  defp initial do
    Image.transform(".#./..#/###")
  end

  defp execute(patterns, iters) do
    img = Enum.reduce(0..iters - 1, initial(), fn i, img ->
      IO.puts "#{i} => count: #{count_pixels(img)}"
      size = length(img)
      cond do
        rem(size, 2) == 0 -> slice_and_merge(img, patterns, 2)
        rem(size, 3) == 0 -> slice_and_merge(img, patterns, 3)
      end
    end)

    count_pixels(img)
  end

  defp count_pixels(img) do
    c = %{?# => 1, ?. => 0}
    img |> Enum.map(fn line ->
      line
      |> String.to_charlist
      |> Enum.map(&(c[&1]))
      |> Enum.sum
    end)
    |> Enum.sum
  end

  defp slice_and_merge(img, patterns, split_by) do
    size = length(img)
    ranges = Enum.take_every(0..size - 1, split_by)

    images = Task.async_stream(ranges, fn y -> 
      y_range = y..y + split_by - 1
      Task.async_stream(ranges, fn x ->
        x_range = x..x + split_by - 1
        slice_img = Image.slice(img, x_range, y_range)
        Map.fetch!(patterns, slice_img)
      end)
      |> Enum.map(fn {:ok, img} -> img end)
    end)
    |> Enum.map(fn {:ok, imgs} -> imgs end)

    Enum.flat_map(images, fn y_imgs -> 
      import Enum
      y_imgs
      |> zip
      |> map(fn x_img -> x_img |> Tuple.to_list |> join end)
    end)
  end

  defp load_data(filename) do
    import String
    filename
    |> File.stream!
    |> Enum.map(fn line ->
      [key, val] = line
                   |> split("=>")
                   |> Enum.map(fn x -> x |> trim |> Image.transform end)
      {key, val}
    end)
    |> Map.new 
  end

  defp generate_missing(data) do
    data 
    |> Enum.flat_map(fn {key, val} -> 
      [
        {Image.flip_x(key), val},
        {Image.flip_y(key), val},
        {Image.rorate_90(key), val},
        {Image.rorate_90(key) |> Image.flip_x, val},
        {Image.rorate_90(key) |> Image.flip_y, val},
        {Image.rorate_270(key), val},
        {Image.rorate_270(key) |> Image.flip_x, val},
        {Image.rorate_270(key) |> Image.flip_y, val},
        {Image.rorate_180(key), val},
      ]
    end)
    |> Map.new
    |> Map.merge(data)
  end

end

TaskTwentyOne.start
