defmodule TaskNine do

  def start do
    stream = load_stream("input.txt")
    {score, garbage_chars} = execute(stream)
    IO.inspect score, label: "score"
    IO.inspect garbage_chars, label: "garbage chars total"
  end

  defp load_stream(filename) do
    File.stream!(filename, [], 1)
  end

  defp execute(stream) do
    # available states - :ok, :garbage, :cancel_ok, :cancel_garbage
    init = {:ok, 0, 0, 0}  # {state, score, nested, garbage_chars}
    {_state, score, _nested, garbage_chars} = Enum.reduce(stream, init, &step/2)
    {score, garbage_chars}
  end

  # catch garbage
  defp step("<", {:ok, c, n, gc}), do: {:garbage, c, n, gc}
  defp step(">", {:garbage, c, n, gc}), do: {:ok, c, n, gc}

  # catch groups
  defp step("{", {:ok, c, n, gc}), do: {:ok, c, n + 1, gc}
  defp step("}", {:ok, c, n, gc}), do: {:ok, c + n, n - 1, gc}

  # cancels
  defp step("!", {:garbage, c, n, gc}), do: {:cancel_garbage, c, n, gc}
  defp step("!", {:ok, c, n, gc}), do: {:cancel_ok, c, n, gc}
  defp step(_, {:cancel_garbage, c, n, gc}), do: {:garbage, c, n, gc}
  defp step(_, {:cancel_ok, c, n, gc}), do: {:ok, c, n, gc}

  #count garbage
  defp step(_, {:garbage, c, n, gc}), do: {:garbage, c, n, gc + 1}

  # else
  defp step(_, result), do: result
end

TaskNine.start
