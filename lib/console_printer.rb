# frozen_string_literal: true

# prints the tic-tac-toe gameboard to the console
module ConsolePrinter
  def max_cell_width
    # cell width necessary for centered number,  ex: | 1 |, | 10 |, | 100 |
    @board.size.to_s.length + 2
  end

  def print
    print_values =
      @board.map.with_index do |marker, index|
        contents = marker.nil? ? (index + 1).to_s : marker
        format_space(contents)
      end

    puts as_grid(print_values)
  end

  private

  def format_space(contents)
    color_stripped_contents = contents.gsub(/\e\[([;\d]+)?m/, '')
    spaces_to_fill = max_cell_width - color_stripped_contents.to_s.length
    left_pad = (spaces_to_fill / 2) + (spaces_to_fill % 2)
    right_pad = spaces_to_fill / 2

    ' ' * left_pad + contents.to_s + ' ' * right_pad
  end

  def pad_contents(contents)
    color_stripped_contents = contents.gsub(/\e\[([;\d]+)?m/, '')
    spaces_to_fill = max_cell_width - color_stripped_contents.to_s.length
    left_pad = (spaces_to_fill / 2) + (spaces_to_fill % 2)
    right_pad = spaces_to_fill / 2

    ' ' * left_pad + contents.to_s + ' ' * right_pad
  end

  def as_grid(contents_array)
    grid = ''
    index = 0

    @board.size.times do
      grid += contents_array[index]
      grid += last_column?(index) ? "\n" : '|'
      grid += row_separator if last_column?(index) && !last_row?(index)
      index += 1
    end

    grid
  end

  def last_column?(index)
    ((index + 1) % @size).zero?
  end

  def last_row?(index)
    (index / @size) == (@size - 1)
  end

  def row_separator
    separator = ''

    @size.times do
      separator += '-' * max_cell_width
      separator += '+'
    end

    separator.chop << "\n"
  end
end
