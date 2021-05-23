require_relative 'board_printer'

class ArrayBoard
  include BoardPrinter

  attr_reader :size

  def initialize(size)
    @size = size
    @board = Array.new(size * size) { Hash.new }

    # p "@size: #{@size} | size: #{size}"
    set_initial_hash_slot
  end

  def mark(slot, marker, color = nil)
    cell = @board.find { |cell| cell[:slot] == slot}
    cell[:color] = color unless color.nil?
    cell[:marker] = marker
  end

  def slot_free?(slot)
    cell = @board.find { |cell| cell[:slot] == slot}
    cell[:marker].nil?
  end

  private

  def set_initial_hash_slot
    @board.each_index { |i| @board[i][:slot] = (i + 1).to_s}
  end
end