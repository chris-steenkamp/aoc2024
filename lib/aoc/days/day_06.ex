defmodule AOC.Days.Day06 do
  alias AOC.Helpers

  def sample1(input \\ "day06/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day06/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day06/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day06/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(lines) do
    height = length(lines)
    width = String.length(Enum.at(lines, 0))

    find = fn c ->
      lines
      |> Enum.with_index()
      |> Enum.find_value(fn {line, y} ->
        case String.split(line, "", trim: true)
             |> Enum.with_index()
             |> Enum.find(fn {char, _x} -> char == c end) do
          nil -> nil
          {_char, x} -> {x, y}
        end
      end)
    end

    dirs = %{"^" => {0, -1}, ">" => {1, 0}, "v" => {0, 1}, "<" => {-1, 0}}
    next_direction = %{"^" => ">", ">" => "v", "v" => "<", "<" => "^"}
    direction = "^"
    start = find.("^")
    locations = MapSet.new([start])

    in_bounds? = fn {x, y} ->
      x >= 0 and y >= 0 and x < height and y < width
    end

    at = fn {x, y} ->
      case in_bounds?.({x, y}) do
        true -> String.at(Enum.at(lines, y), x)
        false -> "-"
      end
    end

    get_next_move = fn f, {x, y}, direction ->
      {dx, dy} = dirs[direction]
      next = {x + dx, y + dy}

      case at.(next) == "#" do
        true -> f.(f, {x, y}, next_direction[direction])
        false -> [next, direction]
      end
    end

    move = fn f, {x, y}, direction, acc ->
      [next, direction] = get_next_move.(get_next_move, {x, y}, direction)

      case in_bounds?.(next) do
        false -> acc
        true -> f.(f, next, direction, MapSet.put(acc, next))
      end
    end

    move.(move, start, direction, locations)
    |> MapSet.size()
  end

  def solve_part2(lines) do
    height = length(lines)
    width = String.length(Enum.at(lines, 0))

    find = fn c ->
      lines
      |> Enum.with_index()
      |> Enum.find_value(fn {line, y} ->
        case String.split(line, "", trim: true)
             |> Enum.with_index()
             |> Enum.find(fn {char, _x} -> char == c end) do
          nil -> nil
          {_char, x} -> {x, y}
        end
      end)
    end

    dirs = %{"^" => {0, -1}, ">" => {1, 0}, "v" => {0, 1}, "<" => {-1, 0}}
    next_direction = %{"^" => ">", ">" => "v", "v" => "<", "<" => "^"}
    direction = "^"
    start = find.("^")

    in_bounds? = fn {x, y} ->
      x >= 0 and y >= 0 and x < height and y < width
    end

    replace_char_at = fn lines, {x, y}, new_char ->
      List.update_at(lines, y, fn line ->
        String.slice(line, 0, x) <>
          new_char <> String.slice(line, (x + 1)..(String.length(line) - 1)//1)
      end)
    end

    at = fn lines, {x, y} ->
      case in_bounds?.({x, y}) do
        true -> String.at(Enum.at(lines, y), x)
        false -> "-"
      end
    end

    get_next_move = fn
      f, lines, {x, y}, direction ->
        {dx, dy} = dirs[direction]
        next = {x + dx, y + dy}

        case at.(lines, next) == "#" do
          true -> f.(f, lines, {x, y}, next_direction[direction])
          false -> [next, direction]
        end
    end

    move = fn f, lines, {x, y}, direction, {acc, state} ->
      [next, direction] = get_next_move.(get_next_move, lines, {x, y}, direction)

      case in_bounds?.(next) do
        false ->
          {acc, :out_of_bounds}

        true ->
          past_directions = Map.get(acc, next, MapSet.new())

          case MapSet.member?(past_directions, direction) do
            false ->
              f.(
                f,
                lines,
                next,
                direction,
                {Map.put(acc, next, MapSet.put(past_directions, direction)), state}
              )

            true ->
              {acc, :loop}
          end
      end
    end

    {locations, _} =
      move.(move, lines, start, direction, {%{start => MapSet.new([direction])}, :start})

    locations =
      locations
      |> Enum.map(fn {loc, _} -> loc end)
      |> MapSet.new()

    for y <- 0..(width - 1) do
      for x <- 0..(height - 1) do
        case at.(lines, {x, y}) != "#" and at.(lines, {x, y}) != "^" and
               MapSet.member?(locations, {x, y}) do
          true ->
            lines = replace_char_at.(lines, {x, y}, "#")

            {_, exit_type} =
              move.(move, lines, start, direction, {%{start => MapSet.new([direction])}, :start})

            case exit_type == :loop do
              true -> {{x, y}, true}
              false -> {{x, y}, false}
            end

          false ->
            {{x, y}, false}
        end
      end
    end
    |> Enum.map(
      &(Enum.map(&1, fn {_, y} ->
          y
        end)
        |> Enum.count(fn x -> x end))
    )
    |> Enum.sum()
  end
end
