defmodule AOC.Helpers do
  def get_lines(filename, trim \\ true) do
    Path.join(["priv", "inputs", filename])
    |> File.read!()
    |> get_grid(trim)
  end

  def get_grid(lines, trim \\ true) do
    lines
    |> String.split(~r/\r?\n/, trim: trim)
  end

  def out_of_bounds?(grid, {x, y}) do
    x < 0 or
      y < 0 or
      x >= Enum.at(grid, 0) |> String.length() or
      y >= length(grid)
  end

  def in_bounds?(grid, {x, y}) do
    not out_of_bounds?(grid, {x, y})
  end

  def at(grid, {x, y}) do
    case in_bounds?(grid, {x, y}) do
      true -> String.at(Enum.at(grid, y), x)
      false -> nil
    end
  end

  def set_char_at(grid, {x, y}, new_char) do
    List.update_at(grid, y, fn line ->
      String.slice(line, 0, x) <>
        new_char <> String.slice(line, (x + 1)..(String.length(line) - 1)//1)
    end)
  end
end
