defmodule AOC.Days.Day09 do
  alias AOC.Helpers

  def sample1(input \\ "day09/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day09/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day09/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day09/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(grid) do
    str =
      grid
      |> Enum.at(0)
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.reduce([], fn {c, i}, acc ->
        case rem(i, 2) do
          r when r === 0 ->
            acc ++ List.duplicate(div(i, 2), c)

          r when r === 1 ->
            acc ++ List.duplicate(nil, c)
        end
      end)

    str_rev =
      str
      |> Enum.reverse()
      |> Enum.filter(fn x -> x != nil end)

    {m, _, c} =
      str
      |> Enum.reduce({[], 0, length(str)}, fn i, {acc, l, l2} ->
        cond do
          i === nil ->
            {[Enum.at(str_rev, l) | acc], l + 1, l2 - 1}

          true ->
            {[i | acc], l, l2}
        end
      end)

    m
    |> Enum.reverse()
    |> Enum.slice(0, c)
    |> Enum.with_index()
    |> Enum.map(fn {id, index} -> id * index end)
    |> Enum.sum()
  end

  def solve_part2(grid) do
    # TODO: Implement solution
    0
  end
end
