defmodule AOC.Helpers do
  def get_lines(filename, trim \\ true) do
    Path.join(["priv", "inputs", filename])
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: trim)
  end
end
