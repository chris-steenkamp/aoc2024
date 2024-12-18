defmodule AOC.Days.Day15 do
  alias AOC.Helpers, as: H

  def sample1(input \\ "day15/sample.txt") do
    input
    |> H.get_lines(false)
    |> solve_part1()
  end

  def sample2(input \\ "day15/sample.txt") do
    input
    |> H.get_lines(false)
    |> solve_part2()
  end

  def part1(input \\ "day15/input.txt") do
    input
    |> H.get_lines(false)
    |> solve_part1()
  end

  def part2(input \\ "day15/input.txt") do
    input
    |> H.get_lines(false)
    |> solve_part2()
  end

  def solve_part1(grid) do
    draw = fn grid ->
      grid
      |> Enum.map(&IO.puts/1)

      IO.puts("")
    end

    swap = fn grid, old_pos, new_pos ->
      old_char = H.at(grid, old_pos)
      new_char = H.at(grid, new_pos)

      temp = H.set_char_at(grid, old_pos, new_char)
      H.set_char_at(temp, new_pos, old_char)
    end

    update_grid = fn f, grid, robot_position, direction, box_count ->
      {new_pos, box_offset, robot_offset} =
        case direction do
          "<" -> {H.move_left(robot_position), {box_count, 0}, {1, 0}}
          "^" -> {H.move_up(robot_position), {0, box_count}, {0, 1}}
          ">" -> {H.move_right(robot_position), {-box_count, 0}, {-1, 0}}
          "v" -> {H.move_down(robot_position), {0, -box_count}, {0, -1}}
        end

      first_box_position = H.add_points(new_pos, box_offset)

      robot_position =
        cond do
          box_count > 0 -> H.add_points(first_box_position, robot_offset)
          true -> robot_position
        end

      cond do
        H.out_of_bounds?(grid, new_pos) ->
          {grid, robot_position}

        H.at(grid, new_pos) === "#" ->
          {grid, robot_position}

        H.at(grid, new_pos) === "O" ->
          f.(f, grid, new_pos, direction, box_count + 1)

        true ->
          {grid, robot_position, new_pos} =
            cond do
              box_count > 0 ->
                grid = swap.(grid, first_box_position, new_pos)

                {grid, robot_position, first_box_position}

              true ->
                {grid, robot_position, new_pos}
            end

          grid = swap.(grid, robot_position, new_pos)
          {grid, new_pos}
      end
    end

    move = fn grid, robot_position, direction ->
      # IO.puts("Moving #{direction}")
      update_grid.(update_grid, grid, robot_position, direction, 0)
    end

    [warehouse, moves] =
      grid
      |> Enum.chunk_by(&(&1 === ""))
      |> Enum.reject(&(&1 === [""]))

    start = H.find(warehouse, "@")

    moves
    |> Enum.flat_map(&String.graphemes/1)
    |> Enum.reduce({warehouse, start}, fn m, {warehouse, robot_position} ->
      move.(warehouse, robot_position, m)
      # {warehouse, robot_position} = move.(warehouse, robot_position, m)
      # draw.(warehouse)
      # {warehouse, robot_position}
    end)
    |> elem(0)
    |> Enum.with_index()
    |> Enum.flat_map(fn {line, y} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.filter(fn {box, _} ->
        box === "O"
      end)
      |> Enum.map(fn {_, x} -> y * 100 + x end)
    end)
    |> Enum.sum()
  end

  def solve_part2(grid) do
    # TODO: Implement solution
    0
  end
end
