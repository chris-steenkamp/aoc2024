defmodule AOC.Days.Day08 do
  alias AOC.Helpers, as: H

  def sample1(input \\ "day08/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day08/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day08/input.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day08/input.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  defp map_grid_chars([]), do: %{}
  # def map_grid_chars([[] | _]), do: %{}

  defp map_grid_chars(grid) do
    for y <- 0..(length(grid) - 1),
        x <- 0..(String.length(Enum.at(grid, 0)) - 1),
        char = H.at(grid, {x, y}),
        char != ".",
        reduce: %{} do
      acc -> Map.update(acc, char, MapSet.new([{x, y}]), &MapSet.put(&1, {x, y}))
    end
  end

  defp get_antinodes({p1, p2}) do
    {dx, dy} = H.calculate_absolute_offset(p1, p2)

    case H.calculate_slope(p1, p2) do
      s when s > 0 -> [H.add_points(p1, {-dx, -dy}), H.add_points(p2, {dx, dy})]
      s when s < 0 -> [H.add_points(p1, {dx, -dy}), H.add_points(p2, {-dx, dy})]
      0 -> [H.add_points(p1, {-dx, 0}), H.add_points(p2, {dx, 0})]
      :undefined -> [H.add_points(p1, {0, -dy}), H.add_points(p2, {0, dy})]
    end
  end

  defp pair([a | rest]) do
    current_pairs =
      Enum.map(rest, fn b ->
        {{_, y1}, {_, y2}} = {a, b}

        # always ensure that p1 is above p2
        cond do
          y1 > y2 -> {b, a}
          true -> {a, b}
        end
      end)

    case rest do
      [] -> current_pairs
      _ -> current_pairs ++ pair(rest)
    end
  end

  defp pair([]) do
    []
  end

  def solve_part1(grid) do
    grid
    |> map_grid_chars()
    |> Enum.map(fn {_, v} -> MapSet.to_list(v) end)
    |> Enum.flat_map(&pair/1)
    |> Enum.flat_map(&get_antinodes/1)
    |> Enum.filter(fn x -> H.in_bounds?(grid, x) end)
    |> Enum.uniq()
    |> Enum.count()
  end

  def solve_part2(grid) do
    # TODO: Implement solution
    0
  end
end
