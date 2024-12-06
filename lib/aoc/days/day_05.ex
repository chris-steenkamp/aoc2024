defmodule AOC.Days.Day05 do
  alias AOC.Helpers

  def sample1(input \\ "day05/sample.txt") do
    input
    |> Helpers.get_lines(false)
    |> solve_part1()
  end

  def sample2(input \\ "day05/sample.txt") do
    input
    |> Helpers.get_lines(false)
    |> solve_part2()
  end

  def part1(input \\ "day05/input.txt") do
    input
    |> Helpers.get_lines(false)
    |> solve_part1()
  end

  def part2(input \\ "day05/input.txt") do
    input
    |> Helpers.get_lines(false)
    |> solve_part2()
  end

  def solve_part1(lines) do
    [d, instructions] =
      lines
      # Split into chunks at empty lines
      |> Enum.chunk_by(&(&1 == ""))
      |> Enum.reject(&(&1 == [""]))

    dependencies =
      d
      |> Enum.reduce(%{}, fn element, counter ->
        [x, y] = String.split(element, "|")
        map1 = Map.get(counter, 1, Map.new())
        map2 = Map.get(counter, 2, Map.new())
        map1 = Map.put(map1, y, MapSet.put(Map.get(map1, y, MapSet.new()), x))
        map2 = Map.put(map2, x, MapSet.put(Map.get(map2, x, MapSet.new()), y))
        Map.put(Map.put(counter, 1, map1), 2, map2)
      end)

    check_updates = fn updates ->
      update_set =
        updates
        |> MapSet.new()

      check_page_acc = fn current_page, processed_pages ->
        # get all the dependencies of the current page
        x_deps = Map.get(dependencies[1], current_page, MapSet.new())

        # get the subset of dependencies which are in the update set
        deps_in_update = MapSet.intersection(x_deps, update_set)

        # check that all dependencies have been processed
        have_deps_been_processed =
          deps_in_update
          |> Enum.all?(fn x -> MapSet.member?(processed_pages, x) end)

        cond do
          have_deps_been_processed -> MapSet.put(processed_pages, current_page)
          true -> processed_pages
        end
      end

      updates
      |> Enum.reduce(MapSet.new(), fn current_page, processed_pages ->
        check_page_acc.(current_page, processed_pages)
      end)
    end

    get_mid_value = fn x ->
      {_, index} = x

      Enum.at(instructions, index)
      |> String.split(",")
      |> then(fn x ->
        String.to_integer(Enum.at(x, div(length(x), 2)))
      end)
    end

    instructions
    |> Enum.map(&String.split(&1, ","))
    |> Enum.map(fn x ->
      update_set = MapSet.new(x)
      update_set == MapSet.intersection(check_updates.(x), update_set)
    end)
    |> Enum.with_index()
    |> Enum.filter(fn x ->
      {valid, _} = x
      valid
    end)
    |> Enum.map(fn x ->
      get_mid_value.(x)
    end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    # TODO: Implement solution
    0
  end
end
