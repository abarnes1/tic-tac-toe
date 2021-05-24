module BoardPrinter
  def max_cell_width
    # cell width necessary for centered number,  ex: | 1 |, | 10 | | 100 |
    @board.size.to_s.length + 2
  end

  def print
    print_values =
      @board.map do |cell|
        contents = cell[:marker].nil? ? cell[:slot] : cell[:marker]
        cell_format(contents, cell[:color])
      end

    puts as_grid(print_values)
  end

  private

  def cell_format(contents, color)
    contents = with_padding(contents)
    color.nil? ? contents : with_color(contents, color)
  end

  def with_padding(contents)
    spaces_to_fill = max_cell_width - contents.to_s.length
    left_pad = (spaces_to_fill / 2) + (spaces_to_fill % 2)
    right_pad = spaces_to_fill / 2

    ' ' * left_pad + contents.to_s + ' ' * right_pad
  end

  def with_color(contents, color)
    color.nil? ? contents : "\e[#{color}#{contents}\e[0m"
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
