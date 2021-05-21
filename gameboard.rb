class GameBoard
  def initialize(size = 3)
    @size = size
    @remaining_spots = @size * @size
    # cell width necessary for centered number,  ex: | 1 |, | 10 | | 100 |
    @cell_width = (@size * @size).to_s.length + 2

    @board = Array.new(@size) { Array.new(size, nil) }
  end

  def display_board
    slot = 1
    board = String.new

    @board.each_with_index do |row, row_index|
      display_row = String.new

      row.each_index do |col_index|
        cell_contents = row[col_index].nil? ? slot.to_s : row[col_index]
        display_row << add_padding(cell_contents)
        display_row << '|' unless col_index == (@size - 1)
        slot += 1
      end

      board += display_row

      row_separator = String.new

      @size.times do
        row_separator << '-' * @cell_width
        row_separator << '+' unless row_separator.length == display_row.length
      end

      board << "\n #{row_separator} \n" unless row_index == (@size - 1)
    end

    puts board
  end

  def place_marker(marker, slot)
    if slot_valid?(slot) && slot_free?(slot)
      @board[slot_row(slot)][slot_column(slot)] = marker
      @remaining_spots -= 1
      true
    else
      puts "slot #{slot} is invalid"
      false
    end
  end

  def winner?
    false
  end

  def full?
    @remaining_spots.zero?
  end

  def slot_valid?(slot)
    slot.positive? && slot <= (@size * @size) && slot_free?(slot)
  end

  private

  def add_padding(contents)
    spaces_to_fill = @cell_width - contents.to_s.length
    left_pad = (spaces_to_fill / 2) + (spaces_to_fill % 2)
    right_pad = spaces_to_fill / 2

    ' ' * left_pad + contents + ' ' * right_pad
  end

  def slot_free?(slot)
    @board[slot_row(slot)][slot_column(slot)].nil?
  end

  def slot_row(slot)
    (slot - 1) / @size
  end

  def slot_column(slot)
    (slot - 1) % @size
  end
  
  def row_winner?

  end
end
