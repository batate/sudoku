defmodule Sudoku do
  @moduledoc """
  Documentation for Sudoku.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Sudoku.hello
      :world

  """
  def hello do
    :world
  end
  
  def board( :complete ) do
    [
      1, 2, 3, 4, 
      3, 4, 1, 2, 
      2, 1, 4, 3, 
      4, 3, 2, 1
    ]
  end

  def board( :invalid ) do
    [
      1, 2, 3, 4, 
      1, 4, 1, 2, 
      2, 1, 4, 3, 
      4, 3, 2, 1
    ]
  end
  
  def rows(board) do
    board
    |> Enum.chunk(4)
  end
  
  def columns(board) do
    board 
    |> rows 
    |> Enum.zip 
    |> Enum.map(&Tuple.to_list/1)
  end
  
  def squares(board) do
    board 
    |> Enum.chunk_every(2) 
    |> Enum.chunk_every(4)
    |> Enum.map(&square_row/1)
    |> Enum.concat
  end
  
  def square_row(big_row) do
    big_row 
    |> Enum.chunk_every(2) 
    |> Enum.zip 
    |> Enum.map(&Tuple.to_list/1) 
    |> Enum.map(&List.flatten/1)
  end
  
  def board_meta(board) do
    %{
      rows: rows(board), 
      columns: columns(board),
      squares: squares(board),
      board: board
    }
  end
  
  def strip(row) do
    Enum.filter( row, &(&1 != 0) )
  end
  
  def valid?(%{rows: rows, columns: cols, squares: squares}) do
    valid_lists?(rows) && valid_lists?(cols) && valid_lists?(squares)
  end
  
  def valid_lists?(rows) do
    rows
    |> Enum.all?( &valid_row?/1)
  end
  
  def valid_row?(row) do
    elements = 
      row
      |> strip
      |> Enum.count
    
    unique_elements = 
      row
      |> strip
      |> Enum.uniq
      |> Enum.count
      
    elements == unique_elements
  end
end
