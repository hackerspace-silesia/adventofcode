defmodule TaskEighteen do

  def start do
    data = load_data("input.txt")
    IO.inspect execute_part1_catch(data), label: "part1 recover"
    IO.inspect execute_part2(data), label: "part2"
  end

  defp load_data(filename) do
    filename
    |> File.stream!
    |> Stream.with_index(0)
    |> Task.async_stream(fn {line, key} ->
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

  defp execute_part1_catch(data) do
    try do
      execute_part1(0, data)
    catch
      recover -> recover
    end
  end

  defp execute_part1(index, data, regs \\ %{}, recover \\ nil) do
    word = data[index]
    {_, reg, _} = word
    case step(word, regs) do
      {:set, val} ->
        regs = Map.put(regs, reg, val)
        execute_part1(index + 1, data, regs, recover)
      {:jmp, shift} -> execute_part1(index + shift, data, regs, recover)
      {:snd, _} -> execute_part1(index + 1, data, regs, regs[reg])
      {:rcv, reg} ->
        if (regs[reg] || 0) != 0 do
          throw recover
        else
          execute_part1(index + 1, data, regs, recover)
        end
      :nop -> execute_part1(index + 1, data, regs, recover)
    end
  end

  defp execute_part2(data) do
    Process.flag(:trap_exit, true)
    Agent.start_link(fn -> 0 end, name: :locks)
    first_pid = spawn_link(TaskEighteen, :init_program, [0, data])
    second_pid = spawn_link(TaskEighteen, :init_program, [1, data])

    send first_pid, {:pid, second_pid}
    send second_pid, {:pid, first_pid}

    Enum.map(0..1, fn _ ->
      receive do
        {:EXIT, _, reason} -> reason
      end
    end)
  end

  def init_program(id, data) do
    receive do
      {:pid, second_pid} -> program(id, second_pid, 0, data, %{"p" => id})
    end
  end

  defp program(id, second_pid, index, data, regs, send_count \\ 0) do
    word = data[index]
    if is_nil(word), do: exit({id, send_count})

    {_, reg, _} = word
    case step(word, regs) do
      {:set, val} ->
        regs = Map.put(regs, reg, val)
        program(id, second_pid, index + 1, data, regs, send_count)
      {:jmp, shift} ->
        program(id, second_pid, index + shift, data, regs, send_count)
      {:snd, val} ->
        send second_pid, {:snd, val}
        IO.inspect ["SENDING", id, send_count + 1]
        program(id, second_pid, index + 1, data, regs, send_count + 1)
      {:rcv, reg} -> 
        receive do
          {:snd, val} ->
            regs = Map.put(regs, reg, val)
            program(id, second_pid, index + 1, data, regs, send_count)
        end
        
      :nop -> program(id, second_pid, index + 1, data, regs, send_count)
    end
  end

  def step({order, reg, second_reg}, regs) when is_binary(second_reg) do
    step({order, reg, regs[second_reg] || 0}, regs)
  end

  def step({"snd", reg, _}, regs) when is_binary(reg), do: {:snd, regs[reg]}
  def step({"snd", value, _}, _), do: {:snd, value}
  def step({"rcv", reg, _}, _), do: {:rcv, reg}

  def step({"set", _reg, val}, _), do: {:set, val}
  def step({"add", reg, val}, regs), do: {:set, (regs[reg] || 0) + val}
  def step({"mul", reg, val}, regs), do: {:set, (regs[reg] || 0) * val}
  def step({"mod", reg, val}, regs), do: {:set, rem(regs[reg] || 0, val)}

  def step({"jgz", reg, val}, regs) do
    if regs[reg] > 0, do: {:jmp, val}, else: :nop
  end
end

TaskEighteen.start
