# frozen_string_literal: true

require_relative 'human_player'
require_relative 'computer_player'

class TicTacToe
  def initialize
    @board = nil
    @player1 = nil
    @player2 = nil
    @current_player = nil
  end

  def play_game
    setup_game

    until @board.full?
      @board.display_board
      play_next_turn(@current_player)

      break if @board.winner?

      switch_player
    end

    end_game
  end

  private

  def get_player(marker)
    player = nil
    player_type = nil

    until %w[1 2].include?(player_type)
      # puts "Choose player for #{marker}."
      # print 'Enter 1 for Human or 2 for Computer: '
      # player_type = gets.chomp
      player_type = '1'
      # puts ''
    end

    case player_type
    when '1'
      player = HumanPlayer.new(marker)
    when '2'
      player = 2
    end

    player
  end

  def setup_game
    @player1 = get_player('X')
    @player2 = get_player('O')
    @current_player = @player1

    @board = GameBoard.new(board_size)
  end

  def board_size
    size = nil

    loop do
      puts 'What size game would you like the play?'
      print "Press 'enter' for 3 or enter 3-15: "
      size = gets.chomp
      size = size.empty? ? 3 : size.to_i
      break if size.between?(3, 15)
    end

    puts ''
    size
  end

  def play_next_turn(current_player)
    cell = 0

    until @board.slot_valid?(cell) do
      print "Choose a square for #{current_player.marker}: "
      cell = gets.chomp.to_i
    end

    @board.place_marker(current_player.marker, cell)
    puts ''
  end

  def end_game
    @board.display_board

    if @board.full?
      puts 'Draw :('
    else
      puts "#{@current_player.marker} wins!!!"
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
