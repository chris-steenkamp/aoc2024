defmodule Aoc.Utils.Algorithms do
  alias AOC.Helpers, as: H

  def floodfill(grid, p, visited, regions, region_id, region_value) do
    cond do
      H.out_of_bounds?(grid, p) ->
        {visited, regions, region_id, region_value}

      MapSet.member?(visited, p) ->
        {visited, regions, region_id, region_value}

      H.at(grid, p) != region_value ->
        {visited, regions, region_id, region_value}

      true ->
        region_value = H.at(grid, p)
        visited = MapSet.put(visited, p)

        regions =
          Map.update(regions, region_value, %{region_id => [p]}, fn m ->
            Map.update(m, region_id, [p], &[p | &1])
          end)

        H.get_directions()
        |> Enum.map(&H.add_points(p, &1))
        |> Enum.reduce(
          {visited, regions, region_id, region_value},
          fn new_p, {v, r, region_id, region_value} ->
            floodfill(grid, new_p, v, r, region_id, region_value)
          end
        )
    end
  end

  def get_regions(grid) do
    H.get_points(grid)
    |> Enum.reduce({MapSet.new(), %{}, 0, 0}, fn p, {visited, regions, region_id, region_value} ->
      case MapSet.member?(visited, p) do
        true ->
          {visited, regions, region_id, region_value}

        false ->
          floodfill(grid, p, visited, regions, region_id + 1, H.at(grid, p))
      end
    end)
    |> elem(1)
  end
end
