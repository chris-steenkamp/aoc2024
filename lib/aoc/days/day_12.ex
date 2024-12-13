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
    get_perimeter_v2 = fn point, region_map ->
      [below, above, right, left, bottom_right, top_right, bottom_left, top_left] =
        H.get_directions(true)
        |> Enum.map(&H.add_points(point, &1))

      [
        Enum.all?([above, left] |> Enum.map(&(MapSet.member?(region_map, &1) == false))),
        Enum.all?([below, left] |> Enum.map(&(MapSet.member?(region_map, &1) == false))),
        Enum.all?([above, right] |> Enum.map(&(MapSet.member?(region_map, &1) == false))),
        Enum.all?([below, right] |> Enum.map(&(MapSet.member?(region_map, &1) == false))),

        # diagonal logic
        Enum.all?(
          [below, left]
          |> Enum.map(
            &(MapSet.member?(region_map, &1) && not MapSet.member?(region_map, bottom_left))
          )
        ),
        Enum.all?(
          [below, right]
          |> Enum.map(
            &(MapSet.member?(region_map, &1) && not MapSet.member?(region_map, bottom_right))
          )
        ),
        Enum.all?(
          [above, left]
          |> Enum.map(
            &(MapSet.member?(region_map, &1) && not MapSet.member?(region_map, top_left))
          )
        ),
        Enum.all?(
          [above, right]
          |> Enum.map(
            &(MapSet.member?(region_map, &1) && not MapSet.member?(region_map, top_right))
          )
        )
      ]
      |> Enum.count(& &1)
    end

    A.get_regions(grid)
    |> Enum.flat_map(fn {_plot_value, plot_regions} ->
      plot_regions
      |> Enum.map(fn {_region_id, region_points} ->
        region_map = MapSet.new(region_points)

        region_points
        |> Enum.map(&get_perimeter_v2.(&1, region_map))
        |> Enum.reduce(0, &(&1 + &2))
        |> then(&(&1 * length(region_points)))
      end)
    end)
    |> Enum.sum()
  end
end
