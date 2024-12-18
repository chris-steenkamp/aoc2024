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

defmodule AOC.Days.Day09Test do
  alias AOC.Days.Day09

  use ExUnit.Case

  @moduletag :day09

  test "test the sample inputs" do
    assert Day09.sample1() == 1928
    assert Day09.sample2() == 2858
  end

  @tag :real
  @tag timeout: :infinity
  @tag :slow
  test "test part 1 real inputs" do
    assert Day09.part1() == 6_337_367_222_422
  end

  @tag :real
  test "test par 2 real inputs" do
    assert Day09.part2() == 6_361_380_647_183
  end
end

defmodule AOC.Days.Day10Test do
  alias AOC.Days.Day10

  use ExUnit.Case

  @moduletag :day10

  test "test the sample inputs" do
    assert Day10.sample1() == 36
    assert Day10.sample2() == 81
  end

  @tag :real
  test "test the real inputs" do
    assert Day10.part1() == 719
    assert Day10.part2() == 1530
  end
end

defmodule AOC.Days.Day11Test do
  alias AOC.Days.Day11

  use ExUnit.Case

  @moduletag :day11

  test "test the sample inputs" do
    assert Day11.sample1() == 55312
    assert Day11.sample2() == 65_601_038_650_482
  end

  @tag :real
  @tag timeout: :infinity
  @tag :slow
  test "test the real inputs" do
    assert Day11.part1() == 199_982
    assert Day11.part2() == 237_149_922_829_154
  end
end

defmodule AOC.Days.Day12Test do
  alias AOC.Days.Day12

  use ExUnit.Case

  @moduletag :day12

  test "test the sample inputs" do
    assert Day12.sample1() == 140
    assert Day12.sample2() == 80
  end

  @tag :real
  test "test the real inputs" do
    assert Day12.part1() == 1_424_472
    assert Day12.part2() == 870_202
  end
end

defmodule AOC.Days.Day13Test do
  alias AOC.Days.Day13

  use ExUnit.Case

  @moduletag :day13

  test "test the sample inputs" do
    assert Day13.sample1() == 480
    assert Day13.sample2() == 875_318_608_908
  end

  @tag :real
  test "test the real inputs" do
    assert Day13.part1() == 27105
    assert Day13.part2() == 101_726_882_250_942
  end
end

defmodule AOC.Days.Day14Test do
  alias AOC.Days.Day14

  use ExUnit.Case

  @moduletag :day14

  test "test the sample inputs" do
    assert Day14.sample1() == 12
  end

  @tag :real
  test "test the real inputs" do
    assert Day14.part1() > 55_186_758
    assert Day14.part1() == 231_852_216
    assert Day14.part2() == 8159
  end
end

defmodule AOC.Days.Day15Test do
  alias AOC.Days.Day15

  use ExUnit.Case

  @moduletag :day15

  test "test the sample inputs" do
    assert Day15.sample1() == 10092
    assert Day15.sample2() == 0
  end

  @tag :real
  test "test the real inputs" do
    assert Day15.part1() == 1_414_416
    assert Day15.part2() == 0
  end
end
