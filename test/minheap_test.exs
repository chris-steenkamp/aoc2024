defmodule AOC.Test.MinHeapTest do
  alias Aoc.Utils.DataStructures.MinHeap

  use ExUnit.Case

  @moduletag :datastructures

  test "create a new heap" do
    assert MinHeap.new() == []
  end

  test "insert elements into the heap" do
    heap = MinHeap.new()
    heap = MinHeap.insert(heap, 5)
    heap = MinHeap.insert(heap, 3)
    heap = MinHeap.insert(heap, 8)

    assert heap == [3, 5, 8]
  end

  test "extract the minimum element" do
    heap = MinHeap.new()
    heap = MinHeap.insert(heap, 5)
    heap = MinHeap.insert(heap, 3)
    heap = MinHeap.insert(heap, 8)
    {min, heap} = MinHeap.extract_min(heap)

    assert min == 3
    assert heap == [5, 8]
  end

  test "extract minimum from an empty heap" do
    assert MinHeap.extract_min(MinHeap.new()) == {:error, "Heap is empty"}
  end

  test "complex heap operations" do
    heap = MinHeap.new()
    heap = MinHeap.insert(heap, 10)
    heap = MinHeap.insert(heap, 4)
    heap = MinHeap.insert(heap, 15)
    heap = MinHeap.insert(heap, 1)
    heap = MinHeap.insert(heap, 7)

    assert heap == [1, 4, 15, 10, 7]

    {min, heap} = MinHeap.extract_min(heap)
    assert min == 1
    assert heap == [4, 7, 15, 10]

    {min, heap} = MinHeap.extract_min(heap)
    assert min == 4
    assert heap == [7, 10, 15]

    {min, heap} = MinHeap.extract_min(heap)
    assert min == 7
    assert heap == [10, 15]

    heap = MinHeap.insert(heap, 3)
    assert heap == [3, 15, 10]
  end
end
