defmodule AOC.Days.Day12 do
  alias AOC.Helpers, as: H
  alias Aoc.Utils.Algorithms, as: A

  def sample1(input \\ "day12/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day12/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day12/input.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day12/input.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def solve_part1(grid) do
    A.get_regions(grid)
    |> Enum.flat_map(fn {k, v} ->
      v
      |> Enum.map(fn {region_id, region_points} ->
        {k, region_id, length(region_points), region_points}
      end)
    end)
    |> Enum.map(fn {plot_value, region_id, region_length, region_points} ->
      region_points
      |> Enum.map(fn point ->
        H.get_directions()
        |> Enum.map(&H.add_points(point, &1))
        |> Enum.map(fn new_point ->
          case H.at(grid, new_point) === plot_value do
            true -> 0
            false -> 1
          end
        end)
      end)
      |> Enum.map(fn list ->
        list
        |> Enum.reduce(0, fn perimeter, acc ->
          acc + perimeter
        end)
      end)
      |> Enum.reduce(0, fn p, acc ->
        p + acc
      end)
      |> then(fn p -> {plot_value, region_id, p * region_length} end)
    end)
    |> Enum.map(fn {_, _, c} -> c end)
    |> Enum.sum()
  end

  def solve_part2(grid) do
    # TODO: Implement solution
    0
  end
end
