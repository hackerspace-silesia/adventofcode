defmodule TaskFour do

  def start do
    data = get_data("input")
    count_part1 = count_valid_lines_part1(data)
    count_part2 = count_valid_lines_part2(data)
    IO.inspect count_part1, label: "part1"
    IO.inspect count_part2, label: "part2"
  end

  def get_data(filename) do
    {:ok, raw_data} = File.read(filename)

    raw_data
    |> String.split("\n")
    |> Stream.filter(&(&1 != ""))
    |> Stream.map(&(String.split(&1, " ")))
    |> Enum.to_list
  end

  def count_valid_lines_part1(data) do
    data
    |> Stream.filter(&check_uniq_line/1)
    |> Enum.count()
  end

  def count_valid_lines_part2(data) do
    data
    |> Stream.map(fn line ->
      Enum.map(line, fn cell ->
        cell
        |> String.to_charlist
        |> MapSet.new
      end)
    end)
    |> count_valid_lines_part1()
  end

  def check_uniq_line(line) do
    length(Enum.uniq(line)) == length(line)
  end

end

TaskFour.start
