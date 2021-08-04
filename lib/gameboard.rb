# frozen_string_literal: true

require_relative 'console_printer'

# Contains internal state of tic-tac-toe grid and answers questions about the grid's state
class Gameboard
  include ConsolePrinter

  def initialize(size)
    @size = size
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

  def winner?(marker)
    marked_slots = marked_spaces(marker)
    win_combos.each do |combo|
      return true if (combo - marked_slots).length.zero?
    end

    false
  end

  def full?
    @board.all?
  end

  def marked_spaces(marker = nil)
    if marker.nil?
      @board.map.with_index { |space, index| index_to_cell(index) unless space.nil? }.compact
    else
      @board.map.with_index { |space, index| index_to_cell(index) if space == marker }.compact
    end
  end

  def win_combos
    @win_combos = generate_win_combos if @win_combos.nil?
    @win_combos.clone
  end

  private

  def cell_to_index(cell)
    cell - 1
  end

  def index_to_cell(index)
    index + 1
  end

  def horizontal_winners
    winning_sets = []
    all_slots = @board.map.with_index { |_space, index| index_to_cell(index) }

    @size.times do
      winning_sets << all_slots.slice!(0, @size)
    end

    winning_sets
  end

  def vertical_winners
    winning_sets = Array.new(@size) { [] }

    @board.each_index do |index|
      column = (index + 1) % @size
      winning_sets[column] << index + 1
    end

    winning_sets
  end

  def top_left_to_bottom_right_winner
    spaces = []

    top_left_index = 0

    @size.times do
      spaces << index_to_cell(top_left_index)
      top_left_index += @size + 1
    end

    [spaces]
  end

  def bottom_left_to_top_right_winner
    spaces = []

    bottom_left_index = @size * (@size - 1)

    @size.times do
      spaces << index_to_cell(bottom_left_index)
      bottom_left_index += (1 - @size)
    end

    [spaces]
  end

  def generate_win_combos
    all_combos = []
    all_combos += horizontal_winners
    all_combos += vertical_winners
    all_combos += top_left_to_bottom_right_winner
    all_combos + bottom_left_to_top_right_winner
  end
end
