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

  defp get_inputs(lines) do
    [dependencies, instructions] =
      lines
      # Split into chunks at empty lines
      |> Enum.chunk_by(&(&1 == ""))
      |> Enum.reject(&(&1 == [""]))

    dependencies =
      dependencies
      |> Enum.reduce(%{}, fn element, counter ->
        [x, y] = String.split(element, "|")
        Map.put(counter, y, MapSet.put(Map.get(counter, y, MapSet.new()), x))
      end)

    instructions =
      instructions
      |> Enum.map(&String.split(&1, ","))

    [dependencies, instructions]
  end

  defp check_validity(instructions, dependencies) do
    get_valid_updates = fn updates ->
      update_set =
        updates
        |> MapSet.new()

      check_page_acc = fn current_page, processed_pages ->
        # get all the dependencies of the current page
        x_deps = Map.get(dependencies, current_page, MapSet.new())

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

    instructions
    |> Enum.map(fn x ->
      update_set = MapSet.new(x)
      update_set == MapSet.intersection(get_valid_updates.(x), update_set)
    end)
    |> Enum.with_index()
  end

  defp get_mid_value(updates) do
    updates
    |> then(fn x ->
      String.to_integer(Enum.at(x, div(length(x), 2)))
    end)
  end

  # Helper function to do the actual traversal
  defp traverse(node, graph, visited, result) do
    case MapSet.member?(visited, node) do
      true ->
        {visited, result}

      false ->
        # Mark node as visited
        visited = MapSet.put(visited, node)

        # Get dependencies for this node
        dependencies = Map.get(graph, node, MapSet.new())

        # Recursively process all dependencies first
        {visited, result} =
          Enum.reduce(dependencies, {visited, result}, fn dep, {visited_acc, result_acc} ->
            traverse(dep, graph, visited_acc, result_acc)
          end)

        # After processing all dependencies, add current node to result
        {visited, [node | result]}
    end
  end

  defp post_order_traverse(graph) do
    # Start traversal with empty visited set and result list
    {_, result} =
      Enum.reduce(Map.keys(graph), {MapSet.new(), []}, fn node, {visited, result} ->
        traverse(node, graph, visited, result)
      end)

    result
  end

  def solve_part1(lines) do
    [dependencies, instructions] = get_inputs(lines)

    updates = check_validity(instructions, dependencies)

    updates
    |> Enum.filter(fn {valid, _} -> valid end)
    |> Enum.map(fn {_valid, index} -> get_mid_value(Enum.at(instructions, index)) end)
    |> Enum.sum()
  end

  def solve_part2(lines) do
    [dependencies, instructions] = get_inputs(lines)

    updates = check_validity(instructions, dependencies)

    # graph = post_order_traverse(dependencies)

    updates
    |> Enum.filter(fn {valid, _} -> not valid end)
    |> Enum.map(fn {_, index} ->
      i = Enum.at(instructions, index)
      l = MapSet.new(i)

      new_deps =
        Enum.reduce(i, %{}, fn i, acc ->
          f_dep = MapSet.intersection(l, Map.get(dependencies, i, MapSet.new()))
          Map.put(acc, i, f_dep)
        end)

      graph = post_order_traverse(new_deps)

      graph
      |> Enum.reduce([], fn i, acc ->
        cond do
          MapSet.member?(l, i) -> [i | acc]
          true -> acc
        end
      end)

      # |> Enum.reverse()
    end)
    |> Enum.map(fn x -> get_mid_value(x) end)
    # |> inspect()
    |> Enum.sum()
  end
end
