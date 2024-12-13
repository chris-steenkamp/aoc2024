defmodule AOC.Days.Day13 do
  alias AOC.Helpers, as: H

  def sample1(input \\ "day13/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day13/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day13/input.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day13/input.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  defp get_offsets(s) do
    [_, coords] = String.split(s, ":")
    [[_, x, y]] = Regex.scan(~r/X\+(-?\d+),\sY\+(-?\d+)/, coords)
    {String.to_integer(x), String.to_integer(y)}
  end

  defp get_claw_position(s) do
    [_, coords] = String.split(s, ":")
    [[_, x, y]] = Regex.scan(~r/X=(-?\d+),\sY=(-?\d+)/, coords)
    {String.to_integer(x), String.to_integer(y)}
  end

  defp cramers_rule(a1, a2, b1, b2, c1, c2) do
    div = a1 * b2 - b1 * a2
    x = floor((c1 * b2 - b1 * c2) / div)
    y = floor((a1 * c2 - c1 * a2) / div)

    cond do
      a1 * x + b1 * y === c1 && a2 * x + b2 * y === c2 -> x * 3 + y
      true -> 0
    end
  end

  def solve_part1(grid) do
    grid
    |> Enum.chunk_every(3)
    |> Enum.map(fn [a, b, p] ->
      button_a = get_offsets(a)
      button_b = get_offsets(b)
      claw = get_claw_position(p)
      {button_a, button_b, claw}
    end)
    |> Enum.map(fn {{a1, a2}, {b1, b2}, {c1, c2}} ->
      cramers_rule(a1, a2, b1, b2, c1, c2)
    end)
    |> Enum.sum()
  end

  def solve_part2(grid) do
    offset = 10_000_000_000_000

    grid
    |> Enum.chunk_every(3)
    |> Enum.map(fn [a, b, p] ->
      button_a = get_offsets(a)
      button_b = get_offsets(b)
      claw = get_claw_position(p)
      {button_a, button_b, claw}
    end)
    |> Enum.map(fn {{a1, a2}, {b1, b2}, {c1, c2}} ->
      cramers_rule(a1, a2, b1, b2, c1 + offset, c2 + offset)
    end)
    |> Enum.sum()
  end
end
