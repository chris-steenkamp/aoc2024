defmodule AOC.Days.Day01 do
  alias AOC.Helpers

  def sample1(input \\ "day01/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day01/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day01/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day01/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(lines) do
    lines
    |> Enum.map(fn x -> String.split(x, "   ") end)
    |> Enum.map(fn [a, b] -> {String.to_integer(a), String.to_integer(b)} end)
    |> Enum.unzip()
    |> then(fn {a, b} -> {Enum.sort(a), Enum.sort(b)} end)
    |> then(fn {a, b} -> Enum.zip(a, b) end)
    |> Enum.map(fn {a, b} -> abs(a - b) end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    frequencies =
      lines
      |> Enum.map(fn x -> String.split(x, "   ") end)
      |> Enum.map(fn [_, b] -> b end)
      |> Enum.frequencies()

    lines
    |> Enum.map(fn x -> String.split(x, "   ") end)
    |> Enum.map(fn [a, _] -> String.to_integer(a) * Map.get(frequencies, a, 0) end)
    |> Enum.sum()
  end
end
