defmodule AOC.Days.Day07 do
  alias AOC.Helpers

  def sample1(input \\ "day07/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day07/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day07/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day07/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  defp calculate(a, [], result, _use_concatenation), do: a == result

  defp calculate(a, [b | rest], result, use_concatenation) do
    cond do
      a > result ->
        false

      calculate(a + b, rest, result, use_concatenation) ->
        true

      calculate(a * b, rest, result, use_concatenation) ->
        true

      use_concatenation ->
        concat =
          [a, b]
          |> Enum.map(&Integer.to_string/1)
          |> Enum.join()
          |> String.to_integer()

        calculate(concat, rest, result, use_concatenation)

      true ->
        false
    end
  end

  def solve_part1(lines) do
    lines
    |> Enum.map(fn x -> String.split(x, ":", trim: true) end)
    |> Enum.map(fn [result, inputs] ->
      {String.to_integer(result),
       String.split(inputs, " ", trim: true)
       |> Enum.map(&String.to_integer(&1))}
    end)
    |> Enum.map(fn {result, [a | rest]} ->
      if calculate(a, rest, result, false), do: result, else: 0
    end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    lines
    |> Enum.map(fn x -> String.split(x, ":", trim: true) end)
    |> Enum.map(fn [result, inputs] ->
      {String.to_integer(result),
       String.split(inputs, " ", trim: true)
       |> Enum.map(&String.to_integer(&1))}
    end)
    |> Enum.map(fn {result, [a | rest]} ->
      if calculate(a, rest, result, true), do: result, else: 0
    end)
    |> Enum.sum()
  end
end
