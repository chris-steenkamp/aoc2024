# 🎄 Advent of Code 2024 🎄

Ho ho ho! Welcome to my Advent of Code 2024 solutions repository, where we're solving puzzles with the magic of Elixir! 🎅✨

## 🌟 Project Structure

```
lib/
  ├── dayXX.ex    # Daily solutions
  ├── helpers.ex  # Helper functions
  └── mix/tasks/  # Custom mix tasks
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

## 🧝‍♂️ Directory Structure

Each day's puzzle has its own directory:
```
dayXX/
  ├── input.txt   # Your puzzle input
  └── sample.txt  # Sample input for testing
```

## 🎯 Progress

- [x] Day 1: Sorting Pairs
- [ ] Day 2: Coming soon!
- [ ] More adventures await...

## 🌠 Running Tests

```bash
mix test                    # Run all tests
mix test test/day01_test.exs    # Run specific day's tests
mix test --only day01      # Run tests tagged with :day01
mix test --only real       # Run only real input tests
mix test --exclude real    # Skip real input tests (faster for development)
```

Happy coding and may your solutions be merry and bright! 🎄✨
