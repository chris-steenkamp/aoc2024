defmodule Mix.Tasks.Aoc.New do
  use Mix.Task
  require Logger

  @shortdoc "Creates a new day's files and downloads input"

  def run([day]) do
    # Start required applications for HTTP client
    Application.ensure_all_started(:inets)
    Application.ensure_all_started(:ssl)

    # Pad day with leading zero if needed
    padded_day = String.pad_leading(day, 2, "0")

    create_solution_file(padded_day)
    create_input_directory(padded_day)
    create_sample_file(padded_day)
    download_input(padded_day)
    append_test_module(padded_day)
  end

  defp create_solution_file(day) do
    path = Path.join(["lib", "aoc", "days", "day_#{day}.ex"])

    unless File.exists?(path) do
      template = """
      defmodule AOC.Days.Day#{day} do
        alias AOC.Helpers

        def sample1(input \\\\ "day#{day}/sample.txt") do
          input
          |> Helpers.get_lines()
          |> solve_part1()
        end

        def sample2(input \\\\ "day#{day}/sample.txt") do
          input
          |> Helpers.get_lines()
          |> solve_part2()
        end

        def part1(input \\\\ "day#{day}/input.txt") do
          input
          |> Helpers.get_lines()
          |> solve_part1()
        end

        def part2(input \\\\ "day#{day}/input.txt") do
          input
          |> Helpers.get_lines()
          |> solve_part2()
        end

        def solve_part1(lines) do
          # TODO: Implement solution
          0
        end

        def solve_part2(lines) do
          # TODO: Implement solution
          0
        end
      end
      """

      File.write!(path, template)
      Logger.info("Created #{path}")
    end
  end

  defp create_input_directory(day) do
    path = Path.join(["priv", "inputs", "day#{day}"])
    File.mkdir_p!(path)
    Logger.info("Created #{path}")
  end

  defp create_sample_file(day) do
    path = Path.join(["priv", "inputs", "day#{day}", "sample.txt"])

    unless File.exists?(path) do
      File.write!(path, "")
      Logger.info("Created empty #{path}")
    end
  end

  defp download_input(day) do
    path = Path.join(["priv", "inputs", "day#{day}", "input.txt"])

    unless File.exists?(path) do
      session = System.get_env("AOC_SESSION")

      if session do
        url = "https://adventofcode.com/2024/day/#{String.to_integer(day)}/input"

        headers = [
          {~c"cookie", String.to_charlist("session=#{session}")}
        ]

        case :httpc.request(:get, {String.to_charlist(url), headers}, [], []) do
          {:ok, {{_, 200, _}, _, body}} ->
            File.write!(path, body)
            Logger.info("Downloaded input to #{path}")

          error ->
            Logger.error("Failed to download input: #{inspect(error)}")

            Logger.info(
              "Please set AOC_SESSION environment variable to your session cookie value"
            )
        end
      else
        Logger.warning("AOC_SESSION environment variable not set")

        Logger.info(
          "To download inputs automatically, set AOC_SESSION to your session cookie value"
        )

        Logger.info(
          "You can find this in your browser's developer tools after logging into adventofcode.com"
        )
      end
    end
  end

  defp append_test_module(day) do
    path = Path.join(["test", "all_test.exs"])

    test_module = """

    defmodule AOC.Days.Day#{day}Test do
      alias AOC.Days.Day#{day}

      use ExUnit.Case

      @moduletag :day#{day}

      test "test the sample inputs" do
        assert Day#{day}.sample1() == 0
        assert Day#{day}.sample2() == 0
      end

      @tag :real
      test "test the real inputs" do
        assert Day#{day}.part1() == 0
        assert Day#{day}.part2() == 0
      end
    end
    """

    case File.read(path) do
      {:ok, content} ->
        if not String.contains?(content, "Day#{day}Test") do
          File.write!(path, content <> test_module)
          Logger.info("Appended test module to #{path}")
        end

      {:error, _} ->
        Logger.error("Could not read #{path}")
    end
  end
end
