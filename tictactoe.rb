# frozen_string_literal: true

require_relative 'human_player'
require_relative 'computer_player'

class TicTacToe
  attr_reader :result, :game_count

  def initialize
    @board = nil
    @player1 = nil
    @player2 = nil
    @current_player = nil
    @winner = nil
    @game_count = 0
    @result = nil
  end

  def play_game
    setup_game

    until @board.full?
      @board.print
      play_next_turn(@current_player)

      if @board.winner?(@current_player.marker)
        @winner = @current_player
        break
      end

      switch_player
    end

    end_game
  end

  private

  def get_player(marker, color_code = nil)
    player = nil
    player_type = nil

    until %w[1 2].include?(player_type)
      puts "Choose player for #{marker}."
      print 'Enter 1 for Human or 2 for Computer: '
      player_type = gets.chomp
      puts ''
    end

    case player_type
    when '1'
      player = HumanPlayer.new(marker, color_code)
    when '2'
      player = ComputerPlayer.new(marker, color_code)
    end

    player
  end

  def setup_game
    @player1 = get_player('X', '31m')
    @player2 = get_player('O', '36m')
    @current_player = @player1
    @winner = nil

    @board = ArrayBoard.new(board_size)
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
    slot = 0

    if current_player.instance_of?(HumanPlayer)
      until @board.slot_free?(slot)
        print "Choose a square for #{current_player.marker}: "
        slot = gets.chomp.to_i
      end
    elsif current_player.instance_of?(ComputerPlayer)
      slot = @board.open_slots.sample
      puts "Computer (#{current_player.marker}) chooses slot ##{slot}"
    end

    @board.mark(current_player.marker, slot, current_player.color_code)
    puts ''
  end

  def end_game
    @game_count += 1
    @board.print

    if @winner.nil?
      @result = 'draw'
      puts 'Draw :('
    else
      @result = 'win'
      puts "#{@current_player.marker} wins!!!"
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def minimax(board, depth, maximizing)

  end
end
