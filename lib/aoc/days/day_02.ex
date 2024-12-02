defmodule AOC.Days.Day02 do
  alias AOC.Helpers

  def sample1(input \\ "day02/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day02/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day02/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day02/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(lines) do
    lines
    |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    |> Enum.map(fn x -> Enum.zip(x, tl(x)) end)
    |> Enum.map(fn x -> Enum.map(x, fn {a, b} -> a - b end) end)
    |> Enum.map(fn x -> Enum.zip(x, tl(x)) end)
    |> Enum.map(fn x ->
      Enum.map(x, fn {a, b} ->
        abs(a) in 1..3 and abs(b) in 1..3 and a * b > 0
      end)
    end)
    |> Enum.map(fn x -> Enum.all?(x) end)
    |> Enum.frequencies()
    |> Map.get(true)
  end

  def solve_part2(lines) do
    # TODO: Implement solution
    0
  end
end
