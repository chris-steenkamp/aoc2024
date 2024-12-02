defmodule Helpers do
  def get_lines(filename) do
    filename
    |> File.read!()
    |> String.split(~r/\r?\n/, trim: true)
  end
end
