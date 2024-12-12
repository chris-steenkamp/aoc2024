defmodule AOC.Helpers do
  @directions_4 [{0, 1}, {0, -1}, {1, 0}, {-1, 0}]
  @directions_8 @directions_4 ++ [{1, 1}, {1, -1}, {-1, 1}, {-1, -1}]

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

  def calculate_manhattan_distance({x1, y1}, {x2, y2}) do
    abs(x1 - x2) + abs(y1 - y2)
  end

  def calculate_euclidean_distance({x1, y1}, {x2, y2}) do
    :math.sqrt(:math.pow(x1 - x2, 2) + :math.pow(y1 - y2, 2))
  end

  def calculate_chebyshev_distance({x1, y1}, {x2, y2}) do
    max(abs(x1 - x2), abs(y1 - y2))
  end

  def calculate_absolute_offset({x1, y1}, {x2, y2}) do
    {abs(x2 - x1), abs(y2 - y1)}
  end

  def calculate_offset({x1, y1}, {x2, y2}) do
    {x2 - x1, y2 - y1}
  end

  def add_points({x1, y1}, {x2, y2}) do
    {x1 + x2, y1 + y2}
  end

  def calculate_slope({x1, y1}, {x2, y2}) do
    if x2 === x1 do
      :undefined
    else
      (y2 - y1) / (x2 - x1)
    end
  end

  def get_dimensions(grid) do
    {String.length(Enum.at(grid, 0)), length(grid)}
  end

  def get_points(grid) do
    {width, height} = get_dimensions(grid)

    for y <- 0..height,
        x <- 0..width,
        do: {x, y}
  end

  def get_directions(include_diagonals \\ false) do
    case include_diagonals do
      true -> @directions_8
      false -> @directions_4
    end
  end
end
