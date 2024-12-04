defmodule AOC.Days.Day04 do
  alias AOC.Helpers

  def sample1(input \\ "day04/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day04/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day04/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day04/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(lines) do
    w = String.length(Enum.at(lines, 0))
    grid = lines |> Enum.join()

    # Define the 8 possible directions to check
    directions = [
      # right
      1,
      # left
      -1,
      # down
      w,
      # up
      -w,
      # down-right
      w + 1,
      # down-left
      w - 1,
      # up-right
      -(w - 1),
      # up-left
      -(w + 1)
    ]

    # Check a complete XMAS pattern in a given direction
    check_xmas = fn pos, dir ->
      String.at(grid, pos + dir) == "M" and
        String.at(grid, pos + 2 * dir) == "A" and
        String.at(grid, pos + 3 * dir) == "S"
    end

    # For each X position, check all 8 directions
    grid
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {char, _} -> char == "X" end)
    |> Enum.map(fn {_, pos} ->
      Enum.count(directions, &check_xmas.(pos, &1))
    end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    # TODO: Implement solution
    0
  end
end
