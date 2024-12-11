defmodule AOC.Days.Day10 do
  alias AOC.Helpers, as: H

  @directions [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]

  def sample1(input \\ "day10/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day10/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day10/input.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day10/input.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  defp next(grid, p, height) do
    cond do
      H.out_of_bounds?(grid, p) ->
        MapSet.new()

      H.at(grid, p) === "." ->
        MapSet.new()

      String.to_integer(H.at(grid, p)) !== height ->
        MapSet.new()

      height === 9 ->
        MapSet.new([p])

      true ->
        @directions
        |> Enum.map(&H.add_points(p, &1))
        |> Enum.reduce(MapSet.new(), &MapSet.union(&2, next(grid, &1, height + 1)))
    end
  end

  def solve_part1(grid) do
    {width, height} = H.get_dimensions(grid)

    trailheads =
      for y <- 0..height,
          x <- 0..width,
          H.at(grid, {x, y}) == "0",
          do: {x, y}

    trailheads
    |> Enum.map(fn t -> next(grid, t, 0) end)
    |> Enum.map(&MapSet.size(&1))
    |> Enum.sum()
  end

  def solve_part2(grid) do
    # TODO: Implement solution
    0
  end
end
