defmodule AOC.Test.Helpers do
  alias AOC.Helpers

  use ExUnit.Case

  @moduletag :helpers

  describe "distance calculations" do
    test "manhattan distance" do
      assert Helpers.calculate_manhattan_distance({0, 0}, {3, 4}) == 7
      assert Helpers.calculate_manhattan_distance({-1, -1}, {2, 2}) == 6
      assert Helpers.calculate_manhattan_distance({5, 5}, {5, 5}) == 0
    end

    test "euclidean distance" do
      assert_in_delta Helpers.calculate_euclidean_distance({0, 0}, {3, 4}), 5.0, 0.000001
      assert_in_delta Helpers.calculate_euclidean_distance({-1, -1}, {2, 2}), 4.242641, 0.000001
      assert Helpers.calculate_euclidean_distance({5, 5}, {5, 5}) == 0.0
    end

    test "chebyshev distance" do
      assert Helpers.calculate_chebyshev_distance({0, 0}, {3, 4}) == 4
      assert Helpers.calculate_chebyshev_distance({-1, -1}, {2, 2}) == 3
      assert Helpers.calculate_chebyshev_distance({5, 5}, {5, 5}) == 0
    end
  end

  describe "point calculations" do
    test "calculate_absolute_offset" do
      assert Helpers.calculate_absolute_offset({1, 1}, {4, 5}) == {3, 4}
      assert Helpers.calculate_absolute_offset({-1, -2}, {2, 3}) == {3, 5}
      assert Helpers.calculate_absolute_offset({5, 5}, {2, 1}) == {3, 4}
      assert Helpers.calculate_absolute_offset({0, 0}, {0, 0}) == {0, 0}
    end

    test "calculate_offset" do
      assert Helpers.calculate_offset({1, 1}, {4, 5}) == {3, 4}
      assert Helpers.calculate_offset({4, 5}, {1, 1}) == {-3, -4}
      assert Helpers.calculate_offset({-1, -2}, {2, 3}) == {3, 5}
      assert Helpers.calculate_offset({0, 0}, {0, 0}) == {0, 0}
    end

    test "add_points" do
      assert Helpers.add_points({1, 2}, {3, 4}) == {4, 6}
      assert Helpers.add_points({-1, -2}, {3, 4}) == {2, 2}
      assert Helpers.add_points({0, 0}, {0, 0}) == {0, 0}
      assert Helpers.add_points({1, 1}, {-1, -1}) == {0, 0}
    end

    test "calculate_slope" do
      assert Helpers.calculate_slope({0, 0}, {2, 2}) == 1.0
      assert Helpers.calculate_slope({0, 0}, {2, -2}) == -1.0
      assert Helpers.calculate_slope({0, 0}, {2, 0}) == 0.0
      assert Helpers.calculate_slope({0, 0}, {0, 2}) == :undefined
      assert Helpers.calculate_slope({2, 2}, {2, -2}) == :undefined
    end
  end
end
