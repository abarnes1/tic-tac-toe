require_relative 'board_printer'

class ArrayBoard
  include BoardPrinter

  attr_reader :size

  def initialize(size)
    @size = size
    @board = Array.new(size * size) { Hash.new }

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

  def open_slots
    @board.select {|cell| cell[:marker].nil?}
  end

  def marked_slots(marker = nil)
    if(marker.nil?)
      @board.select {|cell| !cell[:marker].nil?}
    else
      @board.select {|cell| cell[:marker] == marker}
    end
  end

  def random_open_slot
    open_slots[rand(open_slots.length)]
  end

  private

  def set_initial_hash_slot
    @board.each_index { |i| @board[i][:slot] = (i + 1).to_s}
  end
end