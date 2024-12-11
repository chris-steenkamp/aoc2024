defmodule AOC.Days.Day11 do
  alias AOC.Helpers, as: H

  def sample1(input \\ "day11/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day11/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day11/input.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day11/input.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  defp generator(stone) do
    cond do
      stone == "0" ->
        ["1"]

      rem(String.length(stone), 2) == 0 ->
        String.split_at(stone, div(String.length(stone), 2))
        |> then(fn {x, y} -> [x, y] end)
        |> Enum.map(&String.to_integer/1)
        |> Enum.map(&Integer.to_string/1)

      stone ->
        [Integer.to_string(String.to_integer(stone) * 2024)]
    end
  end

  def solve_part1(grid) do
    stones =
      grid
      |> Enum.at(0)
      |> String.split()

    0..24
    |> Enum.reduce(stones, fn _, stones ->
      stones
      |> Enum.flat_map(&generator(&1))
    end)
    |> Enum.count()
  end

  def solve_part2(grid) do
    # TODO: Implement solution
    0
  end
end
