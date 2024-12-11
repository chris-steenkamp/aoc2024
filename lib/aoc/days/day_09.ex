defmodule AOC.Days.Day09 do
  alias AOC.Helpers

  def sample1(input \\ "day09/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def sample2(input \\ "day09/sample.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def part1(input \\ "day09/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part1()
  end

  def part2(input \\ "day09/input.txt") do
    input
    |> Helpers.get_lines()
    |> solve_part2()
  end

  def solve_part1(grid) do
    str =
      grid
      |> Enum.at(0)
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.reduce([], fn {c, i}, acc ->
        case rem(i, 2) do
          r when r === 0 ->
            acc ++ List.duplicate(div(i, 2), c)

          r when r === 1 ->
            acc ++ List.duplicate(nil, c)
        end
      end)

    str_rev =
      str
      |> Enum.reverse()
      |> Enum.filter(fn x -> x != nil end)

    {m, _, c} =
      str
      |> Enum.reduce({[], 0, length(str)}, fn i, {acc, l, l2} ->
        cond do
          i === nil ->
            {[Enum.at(str_rev, l) | acc], l + 1, l2 - 1}

          true ->
            {[i | acc], l, l2}
        end
      end)

    m
    |> Enum.reverse()
    |> Enum.slice(0, c)
    |> Enum.with_index()
    |> Enum.map(fn {id, index} -> id * index end)
    |> Enum.sum()
  end

  def solve_part2(grid) do
    freespace_map =
      grid
      |> Enum.at(0)
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.reduce({%{}, %{}, 0}, fn {size, index}, {fs_acc, f_acc, offset} ->
        is_free_space = rem(index, 2) == 1
        # offset + size}
        span = {offset, size}

        cond do
          is_free_space == true ->
            {
              Map.update(fs_acc, size, [span], &[span | &1]),
              f_acc,
              offset + size
            }

          true ->
            {
              fs_acc,
              Map.update(f_acc, div(index, 2), span, &[span | &1]),
              offset + size
            }
        end
      end)

    {space, blocks, _} = freespace_map
    # space_keys = Map.keys(space)

    blocks
    |> Enum.reverse()
    |> Enum.reduce({[], space}, fn {id, {i, size}}, {b, sp} ->
      # IO.inspect({id, sp})
      space_keys = Map.keys(sp) |> Enum.sort()

      freespace_index =
        Enum.find(space_keys, fn x ->
          x >= size and
            Enum.find(Map.get(sp, x, []), fn {y, _} -> y < i end) != nil

          # Map.get(sp, x, []) != []
        end)

      cond do
        freespace_index == nil ->
          {[{id, i, size} | b], sp}

        true ->
          freespace_locations =
            Map.get(sp, freespace_index)
            |> Enum.sort()

          [{ci, cs}] = freespace_locations |> Enum.take(1)

          cond do
            ci + size < i ->
              new_size = cs - size

              sp =
                Map.update(sp, new_size, [{ci + size, new_size}], &[{ci + size, new_size} | &1])

              sp = Map.update(sp, freespace_index, [], fn x -> Enum.sort(x) |> Enum.drop(1) end)

              {
                [{id, ci, size} | b],
                sp
              }

            true ->
              {[{id, i, size} | b], sp}
          end
      end
    end)
    |> then(fn {p, _} -> p end)
    |> Enum.map(fn {id, start, size} ->
      for i <- 0..(size - 1),
          do: id * (start + i)
    end)
    |> Enum.map(&Enum.sum/1)
    |> Enum.sum()
  end
end
