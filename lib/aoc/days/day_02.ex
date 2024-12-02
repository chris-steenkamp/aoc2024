defmodule AOC.Days.Day02 do
  alias AOC.Helpers

  defp filter_pairs([]), do: []
  defp filter_pairs([[a, true] | [_ | rest]]), do: [[a, true] | filter_pairs(rest)]
  defp filter_pairs([[a, b] | rest]), do: [[a, b] | filter_pairs(rest)]

  def sample1(input \\ "day02/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day02/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day02/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day02/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(lines) do
    lines
    |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    |> Enum.map(fn x -> Enum.zip(x, tl(x)) end)
    |> Enum.map(fn x -> Enum.map(x, fn {a, b} -> a - b end) end)
    |> Enum.map(fn x -> Enum.zip(x, tl(x)) end)
    |> Enum.map(fn x ->
      Enum.map(x, fn {a, b} ->
        abs(a) in 1..3 and abs(b) in 1..3 and a * b > 0
      end)
    end)
    |> Enum.map(fn x -> Enum.all?(x) end)
    |> Enum.frequencies()
    |> Map.get(true)
  end

  def solve_part2(lines) do
    lines
    |> Enum.map(fn x -> String.split(x, " ", trim: true) end)
    |> Enum.map(fn x -> Enum.map(x, fn y -> String.to_integer(y) end) end)
    |> Enum.map(fn x -> Enum.chunk_every(x, 3, 1) end)
    |> Enum.map(fn x ->
      Enum.map(x, fn
        [a, b, c] -> {b - a, c - a}
        [a, b] -> {b - a, b - a}
      end)
    end)
    |> Enum.map(fn x -> Enum.chunk_every(x, 2, 1, :discard) end)
    |> Enum.map(fn x ->
      Enum.map(x, fn [{a, b}, {c, _}] ->
        [
          abs(a) in 1..3 and abs(c) in 1..3 and a * c > 0,
          abs(a) in 1..3 and abs(b) in 1..3 and a * b > 0
        ]
      end)
    end)
    |> Enum.map(fn x -> filter_pairs(x) end)
    |> Enum.map(fn x -> Enum.map(x, fn [a, b] -> a or b end) end)
    |> Enum.map(fn x -> Enum.all?(x) end)
    |> Enum.frequencies()
    |> Map.get(true)
  end
end
