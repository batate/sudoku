defmodule SudokuTest do
  use ExUnit.Case
  doctest Sudoku

  test "greets the world" do
    assert Sudoku.hello() == :world
  end
  
  test "Should return a board" do
    assert Enum.count(Sudoku.board(:complete)) == 16
  end
  
  test "Board should have rows" do
    assert (
      Sudoku.board(:complete)
      |> Sudoku.rows
      |> Enum.count
    ) == 4
  end
  
  test "first row should be 1, 2, 3, 4" do
    assert (
      Sudoku.board(:complete)
      |> Sudoku.rows
      |> hd
    ) == [1, 2, 3, 4]
  end
  
  test "should return squares" do
    assert (
      Sudoku.board(:complete)
      |> Sudoku.squares
      |> Enum.count
    ) == 4

  end
  
  test "should test validity of row" do
    assert Sudoku.valid_row?([1, 2, 3, 4])
    assert Sudoku.valid_row?([1, 2, 0, 4])
    refute Sudoku.valid_row?([1, 2, 0, 2])
  end
  
  test "should test validity of rows" do
    assert( 
      Sudoku.board(:complete)
      |> Sudoku.rows
      |>Sudoku.valid_lists? )
  end
  
  test "should test validity of board" do
    assert(
      Sudoku.board(:complete)
      |> Sudoku.board_meta
      |> Sudoku.valid? 
    )
    
    refute(
      Sudoku.board(:invalid)
      |> Sudoku.board_meta
      |> Sudoku.valid? 
    )
    
  end
end
