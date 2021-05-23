module BoardPrinter
  def max_cell_width
    @board.size.to_s.length + 2
  end

  def print
    print_values =
      @board.map do |cell|
        contents = cell[:marker].nil? ? cell[:slot] : cell[:marker]
        # p "contents: #{contents}"
        cell_format(contents, cell[:color])
      end

    puts "printing board of size #{@size}x#{@size}"
    puts as_grid(print_values)
  end

  private

  def cell_format(contents, color)
    contents = with_padding(contents)
    color.nil? ? contents : with_color(contents, color)
  end

  def with_padding(contents)
    contents
  end

  def with_color(contents, color)
    color.nil? ? contents : "\e[#{color}#{contents}\e[0m"
  end

  def as_grid(contents_array)
    grid = ''
    index = 0

    @board.size.times do
      grid << contents_array[index]
      grid += ((index + 1) % @size).zero? ? "\n" : '|'
      index += 1
    end

    grid
  end
end
