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

  defp get_perimeter_v1(grid, point, plot_value) do
    H.get_directions()
    |> Enum.map(&H.add_points(point, &1))
    |> Enum.map(fn new_point ->
      case H.at(grid, new_point) === plot_value do
        true -> 0
        false -> 1
      end
    end)
    |> Enum.sum()
  end

  def solve_part1(grid) do
    A.get_regions(grid)
    |> Enum.flat_map(fn {plot_value, plot_regions} ->
      plot_regions
      |> Enum.map(fn {_region_id, region_points} ->
        region_points
        |> Enum.map(&get_perimeter_v1(grid, &1, plot_value))
        |> Enum.reduce(0, &(&1 + &2))
        |> then(&(&1 * length(region_points)))
      end)
    end)
    |> Enum.sum()
  end

  def solve_part2(grid) do
    # TODO: Implement solution
    0
  end
end
