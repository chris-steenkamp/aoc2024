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

    test = lines |> Enum.join()

    f = fn i ->
      String.at(test, i + 1) == "M" and
        String.at(test, i + 2) == "A" and
        String.at(test, i + 3) == "S"
    end

    b = fn i ->
      String.at(test, i - 1) == "M" and
        String.at(test, i - 2) == "A" and
        String.at(test, i - 3) == "S"
    end

    u = fn i ->
      String.at(test, i + -1 * h) == "M" and
        String.at(test, i + -2 * h) == "A" and
        String.at(test, i + -3 * h) == "S"
    end

    d = fn i ->
      String.at(test, i + 1 * h) == "M" and
        String.at(test, i + 2 * h) == "A" and
        String.at(test, i + 3 * h) == "S"
    end

    ur = fn i ->
      String.at(test, i - (h - 1)) == "M" and
        String.at(test, i - 2 * (h - 1)) == "A" and
        String.at(test, i - 3 * (h - 1)) == "S"
    end

    # Diagonal up-left (offset pattern: -18, -12, -6)
    ul = fn i ->
      String.at(test, i - (h + 1)) == "M" and
        String.at(test, i - 2 * (h + 1)) == "A" and
        String.at(test, i - 3 * (h + 1)) == "S"
    end

    # Diagonal down-right (offset pattern: +8, +16, +24)
    dr = fn i ->
      String.at(test, i + (h - 1)) == "M" and
        String.at(test, i + 2 * (h - 1)) == "A" and
        String.at(test, i + 3 * (h - 1)) == "S"
    end

    # Diagonal down-left (offset pattern: +6, +12, +18)
    dl = fn i ->
      String.at(test, i + (h + 1)) == "M" and
        String.at(test, i + 2 * (h + 1)) == "A" and
        String.at(test, i + 3 * (h + 1)) == "S"
    end

    checker = fn i ->
      Enum.count([f.(i), b.(i), u.(i), d.(i), ur.(i), ul.(i), dr.(i), dl.(i)], & &1)
    end

    test
    |> String.graphemes()
    |> Enum.with_index()
    |> Enum.filter(fn {char, _index} -> char == "X" end)
    |> Enum.map(fn {_char, index} -> checker.(index) end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    # TODO: Implement solution
    0
  end
end
