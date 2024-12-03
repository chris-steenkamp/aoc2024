# test/day01_test.exs
defmodule AOC.Days.Day01Test do
  alias AOC.Days.Day01

  use ExUnit.Case

  @moduletag :day01

  test "test the sample inputs" do
    assert Day01.sample1() == 11
    assert Day01.sample2() == 31
  end

  @tag :real
  test "test the real inputs" do
    assert Day01.part1() == 1_941_353
    assert Day01.part2() == 22_539_317
  end
end

defmodule AOC.Days.Day02Test do
  alias AOC.Days.Day02

  use ExUnit.Case

  @moduletag :day02

  test "test the sample inputs" do
    assert Day02.sample1() == 2
    assert Day02.sample2() == 4
  end

  @tag :real
  test "test the real inputs" do
    assert Day02.part1() == 598
    assert Day02.part2() == 634
  end
end

defmodule AOC.Days.Day03Test do
  alias AOC.Days.Day03

  use ExUnit.Case

  @moduletag :day03

  test "test the sample inputs" do
    assert Day03.sample1() == 161
    assert Day03.sample2() == 48
  end

  @tag :real
  test "test the real inputs" do
    assert Day03.part1() == 155_955_228
    assert Day03.part2() > 45_024_768
    assert Day03.part2() < 101_681_733
    assert Day03.part2() == 100_189_366
  end
end
