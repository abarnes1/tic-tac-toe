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
    get_players
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
  def get_players
    player_count = 1
    markers = ["O", "X"]

    while player_count <= 2
      player_type = String.new
      player = nil

      until player_type == "1" || player_type == "2" do
        puts "Choose player #{player_count} for #{markers.last}.  Enter 1 for Human or 2 for Computer."
        player_type = gets.chomp 
      end

      if player_type == "1"
        # puts "Human player was chosen."
        player = HumanPlayer.new(markers.pop)
      elsif player_type == "2"
        # puts "Computer player was chosen."
        player = 2
      end

      @player1 = player if player_count == 1
      @player2 = player if player_count == 2

      player_count += 1 
    end

    @current_player = @player1
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
    @current_player = (@current_player == @player1) ? @player2 : @player1
  end
end
