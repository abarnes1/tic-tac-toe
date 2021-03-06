# frozen_string_literal: true

require_relative 'human_player'
require_relative 'computer_player'

# tic tac toe game logic
class TicTacToe
  attr_reader :result, :current_player

  def initialize
    @board = nil
    @player1 = nil
    @player2 = nil
    @current_player = nil
    @winner = nil
  end

  def play_game
    setup_game

    until full?

      @board.print
      play_next_turn(@current_player)

      if winner?(@current_player.marker)
        @winner = @current_player
        break
      end

      switch_player
    end

    end_game
  end

  def create_player(marker, color_code = nil)
    player_type = ask_player_type(marker)

    case player_type
    when '1'
      HumanPlayer.new(marker, color_code)
    when '2'
      ComputerPlayer.new(marker, color_code)
    end
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end

  def ask_player_type(marker)
    player_type = nil

    until %w[1 2].include?(player_type)
      puts "Choose player for #{marker}."
      print 'Enter 1 for Human or 2 for Computer: '
      player_type = gets.chomp
      puts ''
    end

    player_type
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

  def setup_game
    @player1 = create_player('X', '31m')
    @player2 = create_player('O', '36m')
    @current_player = @player1
    @winner = nil

    @board = Gameboard.new(board_size)
  end

  def winner?(marker)
    @board.winner?(marker)
  end

  def full?
    @board.full?
  end

  private

  def play_next_turn(current_player)
    space = -1

    if current_player.instance_of?(HumanPlayer)
      until @board.space_free?(space)
        print "Choose a space for #{current_player.marker}: "
        space = gets.chomp.to_i
      end
    elsif current_player.instance_of?(ComputerPlayer)
      space = @board.open_spaces.sample
      puts "Computer (#{current_player.marker}) chooses space ##{space}"
    end

    @board.mark(space, current_player.marker)
    puts ''
  end

  def end_game
    @board.print

    puts @winner.nil? ? 'Draw :(' : "#{@current_player.marker} wins!!!"
  end
end
