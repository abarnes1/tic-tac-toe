# frozen_string_literal: true

require_relative 'gameboard_printer'

# Used to contain and control the tic-tac-toe grid itself via
# public methods that prevent the game from being tampered with
class Gameboard
  include GameboardPrinter

  attr_reader :size

  def initialize(size)
    @size = size
    @board = Array.new(size * size) { Hash.new }

    initialize_slot_values
    @win_combos = generate_win_combos
  end

  def mark(marker, slot, color = nil)
    marked = @board.find { |cell| cell[:slot] == slot }
    marked[:color] = color unless color.nil?
    marked[:marker] = marker
  end

  def slot_free?(slot)
    free = @board.find { |cell| cell[:slot] == slot }
    free.nil? ? false : free[:marker].nil?
  end

  def open_slots
    @board.map { |cell| cell[:slot] if cell[:marker].nil? }.compact
  end

  def full?
    open_slots.length.zero?
  end

  def winner?(marker)
    marked_slots = marked_slots(marker)
    @win_combos.each do |combo|
      return true if (combo - marked_slots).length.zero?
    end

    false
  end

  def marked_slots(marker = nil)
    if marker.nil?
      @board.map { |cell| cell[:slot] unless cell[:marker].nil? }.compact
    else
      @board.map { |cell| cell[:slot] if cell[:marker] == marker }.compact
    end
  end

  def win_combos
    @win_combos.map
  end

  private

  def horizontal_winners
    winning_sets = Array.new(@size) { Array.new }
    slot_array = @board.map { |cell| cell[:slot] }

    index = 0
    @size.times do
      winning_sets[index] = slot_array.slice!(0, @size)
      index += 1
    end

    winning_sets
  end

  def vertical_winners
    winning_sets = Array.new(@size) { Array.new }

    @board.each_with_index do |cell, index|
      winning_sets[index % @size] << cell[:slot]
    end

    winning_sets
  end

  def diagonal_winners
    down = []
    up = []

    up_index = @size * (@size - 1)
    down_index = 0

    @size.times do
      down << @board[down_index][:slot]
      down_index += @size + 1

      up << @board[up_index][:slot]
      up_index += (1 - @size)
    end

    [down, up]
  end

  def generate_win_combos
    all_combos = []
    all_combos += horizontal_winners
    all_combos += vertical_winners
    all_combos += diagonal_winners

    all_combos
  end

  def initialize_slot_values
    @board.each_index { |i| @board[i][:slot] = (i + 1) }
  end
end
