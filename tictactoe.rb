require_relative 'human_player'
require_relative 'computer_player'

class TicTacToe

  def initialize(board_size)
    @board = GameBoard.new(board_size)
    @player1 = nil
    @player2 = nil
    @current_player = nil
  end

  def play_game
    @player1 = get_player('X')
    @player2 = get_player('O')
    @current_player = @player1

    until @board.full?
      @board.display_board
      play_next_turn(@current_player)

      if @board.winner?
        puts "#{@current_player.marker} wins!"
        break
      else
        switch_player
      end
    end

    @board.display_board

    puts 'It was a draw!' if @board.full?
  end

  private

  def get_player(marker)
    player = nil
    player_type = nil

    until %w[1 2].include?(player_type)
      puts "Choose player for #{marker}.  Enter 1 for Human or 2 for Computer."
      player_type = gets.chomp
    end

    case player_type
    when '1'
      player = HumanPlayer.new(marker)
    when '2'
      player = 2
    end

    player
  end

  def play_next_turn(current_player)
    cell = 0

    until @board.slot_valid?(cell)
      puts "Choose a square for #{current_player.marker}:"
      cell = gets.chomp.to_i
    end

    @board.place_marker(current_player.marker, cell)
  end

  def switch_player
    @current_player = @current_player == @player1 ? @player2 : @player1
  end
end
