defmodule TaskEighteen do

  def start do
    data = load_data("input.txt")
    try do
      execute(0, data)
    catch
      recover -> IO.inspect recover, label: "part1 recover"
    end
  end

  defp load_data(filename) do
    filename
    |> File.stream!
    |> Stream.with_index(0)
    |> Task.async_stream(fn {line, key}  ->
      line = String.trim(line)
      [order, reg, val] = case String.split(line, " ") do
        [order, reg] -> [order, reg, ""]
        vals -> vals
      end
      val = case Integer.parse(val) do
        :error -> val
        {int_val, _} -> int_val
      end
      {key, {order, reg, val}}
    end)
    |> Stream.map(fn {:ok, obj} -> obj end)
    |> Map.new

  end

  defp execute(index, data, regs \\ %{}, recover \\ nil) do
    word = data[index]
    if is_nil(word) do
      recover
    else
      {_, reg, _} = word
      case step(word, regs) do
        {:set, val} ->
          regs = Map.put(regs, reg, val)
          execute(index + 1, data, regs, recover)
        {:jmp, shift} -> execute(index + shift, data, regs, recover)
        :snd ->
          recover = regs[reg]
          execute(index + 1, data, regs, recover)
        :rcv ->
          throw recover
          execute(index + 1, data, regs, recover)
        nil -> execute(index + 1, data, regs, recover)
      end
    end
  end

  def step({order, reg, second_reg}, regs) when is_binary(second_reg) do
    step({order, reg, regs[second_reg] || 0}, regs)
  end

  def step({"snd", _, _}, _), do: :snd
  def step({"rcv", reg, _}, regs), do: if (regs[reg] || 0) != 0, do: :rcv, else: nil

  def step({"set", _reg, val}, _), do: {:set, val}
  def step({"add", reg, val}, regs), do: {:set, (regs[reg] || 0) + val}
  def step({"mul", reg, val}, regs), do: {:set, (regs[reg] || 0) * val}
  def step({"mod", reg, val}, regs), do: {:set, rem(regs[reg] || 0, val)}

  def step({"jgz", reg, val}, regs) do
    if regs[reg] > 0, do: {:jmp, val}, else: nil
  end
end

TaskEighteen.start
