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
      for row <- 0..(h - 1),
          col <- 0..(w - 1),
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
        at.(row + 2 * drow, col + 2 * dcol) == "A" and
        at.(row + 3 * drow, col + 3 * dcol) == "S"
    end

    # All possible directions as {row_delta, col_delta}
    directions = [
      # right
      {0, 1},
      # left
      {0, -1},
      # down
      {1, 0},
      # up
      {-1, 0},
      # down-right
      {1, 1},
      # down-left
      {1, -1},
      # up-right
      {-1, 1},
      # up-left
      {-1, -1}
    ]

    # For each X position, check all directions
    x_positions
    |> Enum.map(fn pos ->
      Enum.count(directions, &check_pattern.(pos, &1))
    end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    h = length(lines)
    w = String.length(Enum.at(lines, 0))

    # Find all X positions as {row, col} tuples
    a_positions =
      for row <- 0..(h - 1),
          col <- 0..(w - 1),
          String.at(Enum.at(lines, row), col) == "M",
          do: {row, col}

    # Check if position is within grid bounds
    in_bounds? = fn row, col -> row >= 0 and row < h and col >= 0 and col < w end

    # Get character at position, return nil if out of bounds
    at = fn row, col ->
      if in_bounds?.(row, col), do: String.at(Enum.at(lines, row), col), else: nil
    end

    # Check for X-MAS pattern from a position in a given direction
    check_pattern = fn {row, col}, {drow, dcol}, found ->
      a_pos = {row + drow, col + dcol}

      if at.(a_pos |> elem(0), a_pos |> elem(1)) == "A" and
           at.(row + 2 * drow, col + 2 * dcol) == "S" do
        Map.put(found, a_pos, Map.get(found, a_pos, 0) + 1)
      else
        found
      end
    end

    # We only need to diagonal directions {row_delta, col_delta}
    primary_directions = [
      # down-right
      {1, 1},
      # up-right
      {-1, 1},
      # down-left
      {1, -1},
      # up-left
      {-1, -1}
    ]

    # For each X position, check the diagonals to and count the number of As that form part of more than one MAS X shape
    a_positions
    |> Enum.reduce(%{}, fn pos, found ->
      primary_directions
      |> Enum.reduce(found, fn dir, found ->
        check_pattern.(pos, dir, found)
      end)
    end)
    |> Enum.count(fn {_, v} -> v > 1 end)
  end
end
