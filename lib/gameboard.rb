# frozen_string_literal: true

# Contains internal state of tic-tac-toe grid and answers questions about the grid's state
class Gameboard
  def initialize(size)
    @board = Array.new(size * size)
  end

  def open_spaces
    @board.map.with_index { |item, index| index_to_cell(index) if item.nil? }.compact
  end

  def mark(cell, marker)
    index = cell_to_index(cell)
    @board[index] = marker
  end

  def space_free?(cell)
    index = cell_to_index(cell)
    @board[index].nil?
  end

  def full?
    @board.all?
  end

  private

  def cell_to_index(cell)
    cell - 1
  end

  def index_to_cell(index)
    index + 1
  end
end
