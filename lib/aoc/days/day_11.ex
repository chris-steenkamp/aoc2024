defmodule AOC.Days.Day11 do
  alias AOC.Helpers, as: H
  alias Agent

  def sample1(input \\ "day11/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day11/sample.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day11/input.txt") do
    input
    |> H.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day11/input.txt") do
    input
    |> H.get_lines()
    |> solve_part2()
  end

  defp mem_gen(stone, times) do
    {:ok, _} = Agent.start_link(fn -> %{} end, name: __MODULE__)
    result = generator(stone, times)
    Agent.stop(__MODULE__)
    result
  end

  defp generator(stone, times) do
    case Agent.get(__MODULE__, &Map.get(&1, {stone, times})) do
      nil ->
        result =
          cond do
            times === 0 ->
              1

            stone === 0 ->
              generator(1, times - 1)

            (x = Integer.to_string(stone)) && rem(String.length(x), 2) === 0 ->
              {l, r} = String.split_at(x, div(String.length(x), 2))

              generator(String.to_integer(l), times - 1) +
                generator(String.to_integer(r), times - 1)

            true ->
              generator(stone * 2024, times - 1)
          end

        Agent.update(__MODULE__, &Map.put(&1, {stone, times}, result))
        result

      result ->
        result
    end
  end

  def solve_part1(grid) do
    stones =
      grid
      |> Enum.at(0)
      |> String.split()
      |> Enum.map(&String.to_integer/1)

    stones
    |> Enum.map(&mem_gen(&1, 25))
    |> Enum.sum()
  end

  def solve_part2(grid) do
    stones =
      grid
      |> Enum.at(0)
      |> String.split()
      |> Enum.map(&String.to_integer/1)

    stones
    |> Enum.map(&mem_gen(&1, 75))
    |> Enum.sum()
  end
end
