defmodule AOC.Days.Day03 do
  alias AOC.Helpers

  def sample1(input \\ "day03/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day03/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day03/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day03/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(lines) do
    lines
    |> Enum.map(&Regex.scan(~r/mul\((\d+),(\d+)\)/, &1))
    |> Enum.map(&Enum.map(&1, fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end))
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sum()
  end

  def solve_part2(lines) do
    # TODO: Implement solution
    0
  end
end
