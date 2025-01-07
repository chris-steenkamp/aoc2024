# 🎄 Advent of Code 2024 🎄

Ho ho ho! Welcome to my Advent of Code 2024 solutions repository, where we're solving puzzles with the magic of Elixir! 🎅✨

## 🌟 Project Structure

```ascii
lib/
  ├── aoc/
  │   ├── days/           # Daily solutions
  │   │   ├── day_01.ex
  │   │   ├── day_02.ex
  │   │   └── ...
  │   ├── utils/         # Utility modules
  │   │   └── ...
  │   └── helpers.ex     # Helper functions
  └── mix/tasks/         # Custom mix tasks
test/
  ├── all_test.exs             # Tests for daily solutions
  ├── helper_test.exs          # Tests for helper functions
  ├── minheap_test.exs          # Tests for minheap data structure
  └── test_helper.exs
```

## 🎁 Running Solutions

You can run the solutions in several festive ways:

```bash
# Run samples
mix aoc sample 1 01  # Run sample 1 for day 1
mix aoc sample 2 01  # Run sample 2 for day 1

# Run actual solutions
mix aoc part 1 01    # Run part 1 for day 1
mix aoc part 2 01    # Run part 2 for day 1
```

## 🎮 VS Code Integration

This project includes snippets and launch configurations to make coding more jolly:

1. Use `aocday` snippet to create a new day's solution
2. Use `aoctest` snippet to create matching tests
3. Use the Run and Debug view to execute solutions with a festive UI!

## 🎯 Progress

- [x] Day 1: Sorting Pairs
- [x] Day 2: Pattern Matching
- [x] Day 3: Regex and Pattern Filtering
- [x] Day 4: Grid Pattern Search (XMAS)
- [x] Day 5: Dependency Graph Traversal
- [x] Day 6: Grid Loop Detection with Parallel Processing
- [x] Day 7: Arithmetic Expression Evaluation and String Operations
- [x] Day 8: Grid Geometry and Pattern Extrapolation
- [x] Day 9: Free space mapping with Heap Management
- [x] Day 10: Grid Traversal with Recursive Depth-First Search
- [x] Day 11: Memoization with Agents
- [x] Day 12: Grid traversal and perimeter calculation using functional programming concepts.
- [x] Day 13: Solving systems of linear equations using Cramer's Rule and functional programming concepts like list processing and pattern matching.
- [x] Day 14: This solution implements a simulation of robot movements on a grid.
- [ ] More adventures await...

## 🧠 Functional Programming Concepts

Throughout this journey, we're learning and applying functional programming concepts in Elixir:

- **Pattern Matching**: Using Elixir's powerful pattern matching for data extraction and flow control
- **Immutability**: Working with immutable data structures to maintain program state
- **Higher-Order Functions**: Using functions like `map`, `reduce`, and `filter` for data transformation
- **Pipeline Operator**: Chaining operations with the `|>` operator for cleaner code
- **Recursion**: Solving problems through recursive function calls instead of loops
- **Memoization**: Implementing memoization using Agents to help optimize recursive calculations

## 🌠 Running Tests

```bash
mix test                    # Run all tests
mix test --only day01      # Run tests tagged with :day01
mix test --only real       # Run only real input tests
mix test --exclude real    # Skip real input tests (faster for development)
```

Happy coding and may your solutions be merry and bright! 🎄✨
