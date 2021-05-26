# frozen_string_literal: true

require_relative 'tictactoe'
require_relative 'array_board'

$stdout.sync = true # allows use of print instead of put to keep prompt and input on same line

game = TicTacToe.new

loop do
  game.play_game
  print 'Play again? Enter Y for yes or any other key for no: '
  answer = gets.chomp
  break unless answer.downcase == 'y'
end
