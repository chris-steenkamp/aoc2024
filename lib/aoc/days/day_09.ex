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

    Map.keys(blocks)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.reduce({[], space}, fn id, {b, sp} ->
      {i, size} = Map.get(blocks, id)
      # IO.inspect({id, i, size, b, sp})

      {min_idx, freespace_index} =
        size..10
        |> Enum.reduce({10 ** 18, -1}, fn x, {min_idx, best_width} ->
          heap = Map.get(sp, x, []) |> Enum.sort()

          cond do
            heap == [] ->
              {min_idx, best_width}

            true ->
              [{ix, _} | _] = heap
              {min_idx, best_width} = if min_idx > ix, do: {ix, x}, else: {min_idx, best_width}
              {min_idx, best_width}
          end
        end)

      cond do
        min_idx == 10 ** 18 || freespace_index == nil || freespace_index >= i ->
          {[{id, i, size} | b], sp}

        true ->
          freespace_locations =
            Map.get(sp, freespace_index)
            |> Enum.sort()

          {ci, _cs} = freespace_locations |> Enum.at(0)

          cond do
            ci < i ->
              new_size = freespace_index - size

              sp = Map.update(sp, freespace_index, [], fn x -> Enum.sort(x) |> Enum.drop(1) end)

              sp =
                cond do
                  new_size > 0 ->
                    Map.update(
                      sp,
                      new_size,
                      [{ci + size, new_size}],
                      &([{ci + size, new_size} | &1] |> Enum.sort())
                    )

                  true ->
                    sp
                end

              # IO.inspect(sp)

              {[{id, ci, size} | b], sp}

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
