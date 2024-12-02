defmodule Mix.Tasks.Aoc do
  use Mix.Task

  @shortdoc "Run Advent of Code solutions"
  def run(args) do
    case args do
      ["sample", "1", day] ->
        run_solution(day, :sample1)

      ["sample", "2", day] ->
        run_solution(day, :sample2)

      ["part", "1", day] ->
        run_solution(day, :part1)

      ["part", "2", day] ->
        run_solution(day, :part2)

      _ ->
        IO.puts("""
        Usage:
          mix aoc sample 1 [day]  - Run sample 1 for specific day
          mix aoc sample 2 [day]  - Run sample 2 for specific day

          mix aoc part 1 [day]  - Run part 1 for specific day
          mix aoc part 2 [day]  - Run part 2 for specific day

        Example:
          mix aoc sample 1 01  - Run sample 1 for day 1
          mix aoc part 1 01 - Run part 1 for day 1
        """)
    end
  end

  defp run_solution(day, part) do
    module = String.to_existing_atom("Elixir.AOC.Days.Day#{day}")
    result = apply(module, part, [])
    IO.puts("Result for Day#{day} #{part}: #{result}")
  end
end
