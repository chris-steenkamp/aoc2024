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

defmodule AOC.Days.Day04Test do
  alias AOC.Days.Day04

  use ExUnit.Case

  @moduletag :day04

  test "test the sample inputs" do
    assert Day04.sample1() == 18
    assert Day04.sample2() == 9
  end

  @tag :real
  test "test the real inputs" do
    assert Day04.part1() < 2636
    assert Day04.part1() > 1272
    assert Day04.part1() == 2618
    assert Day04.part2() > 1488
    assert Day04.part2() == 2011
  end
end

defmodule AOC.Days.Day05Test do
  alias AOC.Days.Day05

  use ExUnit.Case

  @moduletag :day05

  test "test the sample inputs" do
    assert Day05.sample1() == 143
    assert Day05.sample2() == 123
  end

  @tag :real
  test "test the real inputs" do
    assert Day05.part1() == 3608
    assert Day05.part2() > 4811
    assert Day05.part2() == 4922
  end
end

defmodule AOC.Days.Day06Test do
  alias AOC.Days.Day06

  use ExUnit.Case

  @moduletag :day06

  test "test the sample inputs" do
    assert Day06.sample1() == 41
    assert Day06.sample2() == 6
  end

  @tag :real
  @tag timeout: :infinity
  @tag :slow
  test "test the real inputs" do
    assert Day06.part1() == 4663
    assert Day06.part2() == 1530
  end
end

defmodule AOC.Days.Day07Test do
  alias AOC.Days.Day07

  use ExUnit.Case

  @moduletag :day07

  test "test the sample inputs" do
    assert Day07.sample1() == 3749
    assert Day07.sample2() == 11387
  end

  @tag :real
  test "test the real inputs" do
    assert Day07.part1() == 5_702_958_180_383
    assert Day07.part2() == 92_612_386_119_138
  end
end

defmodule AOC.Days.Day08Test do
  alias AOC.Days.Day08

  use ExUnit.Case

  @moduletag :day08

  test "test the sample inputs" do
    assert Day08.sample1() == 14
    assert Day08.sample2() == 34
  end

  @tag :real
  test "test the real inputs" do
    assert Day08.part1() == 394
    assert Day08.part2() == 1277
  end
end
