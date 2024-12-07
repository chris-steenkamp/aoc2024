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

  defp calculate(a, [], result), do: a == result

  defp calculate(a, [b | rest], result) do
    cond do
      calculate(a + b, rest, result) -> true
      calculate(a * b, rest, result) -> true
      true -> false
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
      if calculate(a, rest, result), do: result, else: 0
    end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    # TODO: Implement solution
    0
  end
end
