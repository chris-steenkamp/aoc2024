defmodule AOC.Helpers do
  def get_lines(filename) do
    Path.join(["priv", "inputs", filename])
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: true)
  end
end
