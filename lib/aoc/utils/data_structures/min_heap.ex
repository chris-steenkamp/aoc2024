# Implementation of a Min-Heap in Elixir
# A min-heap is a binary tree where each parent node is smaller than or equal to its child nodes.
# We will use a list to represent the heap, where the first element is `nil` (to simplify calculations for indices).

defmodule Aoc.Utils.DataStructures.MinHeap do
  # Initializes an empty heap
  def new do
    []
  end

  # Inserts an element into the heap
  def insert(heap, value) do
    # Append the value to the heap
    heap = heap ++ [value]
    # Bubble up the newly added value to restore the min-heap property
    bubble_up(heap, length(heap) - 1)
  end

  # Helper function: Bubble up the element at the given index
  defp bubble_up(heap, index) when index == 0, do: heap

  defp bubble_up(heap, index) do
    parent_index = div(index - 1, 2)

    if Enum.at(heap, parent_index) > Enum.at(heap, index) do
      heap = swap(heap, parent_index, index)
      bubble_up(heap, parent_index)
    else
      heap
    end
  end

  # Extracts the minimum element (root of the heap)
  def extract_min([]), do: {:error, "Heap is empty"}

  def extract_min(heap) do
    case heap do
      [min] ->
        {min, []}

      _ ->
        # Extract the root (minimum element)
        min = hd(heap)
        # Move the last element to the root
        last = List.last(heap)
        new_heap = List.replace_at(heap, 0, last) |> Enum.drop(-1)
        # Restore heap property
        sifted_heap = sift_down(new_heap, 0)
        {min, sifted_heap}
    end
  end

  # Helper function: Sift down the element at the given index
  defp sift_down(heap, index) do
    left_child = 2 * index + 1
    right_child = 2 * index + 2
    smallest = index

    smallest =
      if left_child < length(heap) && Enum.at(heap, left_child) < Enum.at(heap, smallest),
        do: left_child,
        else: smallest

    smallest =
      if right_child < length(heap) && Enum.at(heap, right_child) < Enum.at(heap, smallest),
        do: right_child,
        else: smallest

    if smallest != index do
      heap = swap(heap, index, smallest)
      sift_down(heap, smallest)
    else
      heap
    end
  end

  # Helper function: Swap two elements in the heap
  defp swap(heap, i, j) do
    heap
    |> List.replace_at(i, Enum.at(heap, j))
    |> List.replace_at(j, Enum.at(heap, i))
  end
end
