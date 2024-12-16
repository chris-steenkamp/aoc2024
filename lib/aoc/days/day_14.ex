defmodule AOC.Days.Day14 do
  alias AOC.Helpers, as: H

  def sample1(input \\ "day14/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part1(11, 7)
  end

  def sample2(input \\ "day14/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day14/input.txt") do
    input
    |> H.get_lines()
    |> solve_part1(101, 103)
  end

  def part2(input \\ "day14/input.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def solve_part1(grid, width, height) do
    robots =
      grid
      |> Enum.map(&Regex.scan(~r/p=(-?\d+),(-?\d+) v=(-?\d+),(-?\d+)/, &1))
      |> Enum.map(fn [[_, x, y, dx, dy]] ->
        {{String.to_integer(x), String.to_integer(y)},
         {String.to_integer(dx), String.to_integer(dy)}}
      end)

    next_position = fn {{x, y}, {dx, dy}} ->
      {new_x, new_y} = H.add_points({x, y}, {dx, dy})

      {
        {rem(new_x + width, width), rem(new_y + height, height)},
        {dx, dy}
      }
    end

    mid_y = div(height, 2)
    mid_x = div(width, 2)

    robots
    |> Enum.map(fn x ->
      Enum.reduce(0..99, {x, MapSet.new()}, fn _, {acc, seen} ->
        # IO.inspect({i, acc, MapSet.member?(seen, acc)})
        {next_position.(acc), MapSet.put(seen, acc)}
      end)
      |> then(fn {{position, _}, _} -> position end)
    end)
    |> Enum.map(fn {x, y} ->
      cond do
        x < mid_x && y < mid_y -> 1
        x > mid_x && y < mid_y -> 2
        x < mid_x && y > mid_y -> 3
        x > mid_x && y > mid_y -> 4
        true -> 0
      end
    end)
    |> Enum.reduce(%{}, fn i, acc -> Map.update(acc, i, 1, &(&1 + 1)) end)
    |> Enum.reduce(1, fn {k, v}, acc -> if k === 0, do: acc, else: acc * v end)
  end

  def solve_part2(grid) do
    # TODO: Implement solution
    0
  end
end
