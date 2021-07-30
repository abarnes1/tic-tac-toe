
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

  private
  
  def cell_to_index(cell)
    cell - 1
  end

  def index_to_cell(index)
    index + 1
  end
end
