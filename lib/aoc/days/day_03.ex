defmodule AOC.Days.Day03 do
  alias AOC.Helpers

  def sample1(input \\ "day03/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day03/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day03/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day03/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(lines) do
    lines
    |> Enum.map(&Regex.scan(~r/mul\((\d+),(\d+)\)/, &1))
    |> Enum.map(&Enum.map(&1, fn [_, a, b] -> String.to_integer(a) * String.to_integer(b) end))
    |> Enum.map(&Enum.sum(&1))
    |> Enum.sum()
  end

  def solve_part2(lines) do
    lines
    # join all the lines together to get one big memory map
    |> Enum.join()
    # put the single line into an array to be compatible with part 1 logic
    |> then(fn x -> [x] end)
    # find all substrings that start with don't() and end with do() and replace them
    # the search needs to be nongreedy to capture the smallest groups possible
    # the dash isn't necessary, I added it because I thought the input might contain
    # data which would form a mul(x,y) operation after removing the matched text.
    # The last part (?:do()|$) can also be reduced to just do() for the given input
    # but this way it can handle don't() that isn't followed by a do() (e.g end of input)
    |> Enum.map(&String.replace(&1, ~r/(don't\(\).*?(?:do\(\)|$))/, "-"))
    |> solve_part1()
  end
end
