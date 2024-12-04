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
    h = length(lines)
    w = String.length(Enum.at(lines, 0))

    # Find all X positions as {row, col} tuples
    x_positions = 
      for row <- 0..(h-1),
          col <- 0..(w-1),
          String.at(Enum.at(lines, row), col) == "X",
          do: {row, col}

    # Check if position is within grid bounds
    in_bounds? = fn row, col -> row >= 0 and row < h and col >= 0 and col < w end

    # Get character at position, return nil if out of bounds
    at = fn row, col ->
      if in_bounds?.(row, col), do: String.at(Enum.at(lines, row), col), else: nil
    end

    # Check for XMAS pattern from a position in a given direction
    check_pattern = fn {row, col}, {drow, dcol} ->
      at.(row + drow, col + dcol) == "M" and
        at.(row + 2*drow, col + 2*dcol) == "A" and
        at.(row + 3*drow, col + 3*dcol) == "S"
    end

    # All possible directions as {row_delta, col_delta}
    directions = [
      {0, 1},    # right
      {0, -1},   # left
      {1, 0},    # down
      {-1, 0},   # up
      {1, 1},    # down-right
      {1, -1},   # down-left
      {-1, 1},   # up-right
      {-1, -1}   # up-left
    ]

    # For each X position, check all directions
    x_positions
    |> Enum.map(fn pos ->
      Enum.count(directions, &check_pattern.(pos, &1))
    end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    # TODO: Implement solution
    0
  end
end
