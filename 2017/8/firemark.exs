defmodule Word do
  defstruct [
    reg: 'a',
    ins: 'inc',
    val: 0,
    if_reg: 'a',
    if_ins: '==',
    if_val: 0,
  ]

  def instruction_to_fn(%Word{ins: ins}) do
    case ins do
      "inc" -> fn a, b -> a + b end
      "dec" -> fn a, b -> a - b end
    end
  end

  def if_instruction_to_fn(%Word{if_ins: if_ins}) do
    case if_ins do
      ">" -> fn a, b -> a > b end
      ">=" -> fn a, b -> a >= b end
      "<" -> fn a, b -> a < b end
      "<=" -> fn a, b -> a <= b end
      "==" -> fn a, b -> a == b end
      "!=" -> fn a, b -> a != b end
    end
  end

end

defmodule TaskEight do

  def start do
    words = load_words("input.txt")
    
    {last_max, max} = execute(words)
    IO.inspect last_max, label: 'the last biggest value'
    IO.inspect max, label: 'the biggest value'
  end

  defp load_words(filename) do
    {:ok, data} = File.read(filename)

    data
    |> String.split("\n")
    |> Stream.filter(&(&1 != ""))
    |> Stream.map(fn line ->
      [reg, ins, val, _if, if_reg, if_ins, if_val] = String.split(line, " ")
      %Word{
        reg: reg,
        ins: ins,
        val: String.to_integer(val),
        if_reg: if_reg,
        if_ins: if_ins,
        if_val: String.to_integer(if_val),
      }
    end)
    |> Enum.to_list
  end

  defp execute(words) do 
    execute(%{}, 0, words)
  end

  defp execute(registries, max, []) do
    last_max = registries |> Map.values |> Enum.max
    {last_max, max}
  end

  defp execute(registries, max, [word | words]) do
    if_ins_fn = Word.if_instruction_to_fn(word)
    if_reg_val = registries[word.if_reg] || 0

    if if_ins_fn.(if_reg_val, word.if_val) do
      {updated_registries, max} = update_registries(registries, max, word)
      execute(updated_registries, max, words)
    else
      execute(registries, max, words)
    end
  end

  defp update_registries(registries, max, word) do
    ins_fn = Word.instruction_to_fn(word)
    reg_val = registries[word.reg] || 0
    new_reg_val = ins_fn.(reg_val, word.val)
    registries = Map.put(registries, word.reg, new_reg_val)
    {registries, Enum.max([new_reg_val, max])}
  end
end

TaskEight.start
