defmodule AOC.Days.Day09 do
  alias AOC.Helpers
  alias DataStructures.MinHeap

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
    heaps = List.duplicate([], 10)

    freespace_map =
      grid
      |> Enum.at(0)
      |> String.graphemes()
      |> Enum.map(&String.to_integer/1)
      |> Enum.with_index()
      |> Enum.reduce({heaps, %{}, 0}, fn {size, index}, {heaps, f_acc, offset} ->
        is_free_space = rem(index, 2) == 1
        # offset + size}
        span = {offset, size}

        cond do
          size == 0 ->
            {heaps, f_acc, offset}

          is_free_space == true ->
            {
              List.update_at(heaps, size, &MinHeap.insert(&1, span)),
              f_acc,
              offset + size
            }

          true ->
            {
              heaps,
              Map.update(f_acc, div(index, 2), span, &[span | &1]),
              offset + size
            }
        end
      end)

    {heaps, blocks, _} = freespace_map

    Map.keys(blocks)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.reduce({[], heaps}, fn id, {b, heaps} ->
      {i, size} = Map.get(blocks, id)
      # IO.inspect({id, i, size, b, sp})

      {min_idx, freespace_index} =
        size..(length(heaps) - 1)
        |> Enum.reduce({10 ** 18, -1}, fn x, {min_idx, best_width} ->
          heap = Enum.at(heaps, x)

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
          {[{id, i, size} | b], heaps}

        # freespace_index >= i ->
        #   {[{id, i, size} | b], heaps}

        true ->
          {freespace_location, new_heap} = MinHeap.extract_min(Enum.at(heaps, freespace_index))

          {ci, _cs} = freespace_location

          cond do
            ci < i ->
              new_size = freespace_index - size

              heaps = List.update_at(heaps, freespace_index, fn _ -> new_heap end)

              heaps =
                cond do
                  new_size > 0 ->
                    List.update_at(heaps, new_size, &MinHeap.insert(&1, {ci + size, new_size}))

                  true ->
                    heaps
                end

              # IO.inspect(heaps)

              {[{id, ci, size} | b], heaps}

            true ->
              {[{id, i, size} | b], heaps}
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
