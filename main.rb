# frozen_string_literal: true

require_relative 'tictactoe'
require_relative 'gameboard'
require_relative 'array_board'

$stdout.sync = true # allows use of print instead of put to keep prompt and input on same line

# game = TicTacToe.new

# loop do
#   game.play_game
#   print 'Play again? Enter Y for yes or any other key for no: '
#   answer = gets.chomp
#   break unless answer.downcase == 'y'
# end

test_board = ArrayBoard.new(4)

test_board.mark('2', 'X', '31m') if test_board.slot_free?('2')
test_board.mark('2', 'O', '32m') if test_board.slot_free?('2')
test_board.mark('3', 'O', '33m') if test_board.slot_free?('3')
test_board.mark('4', 'O', '33m') if test_board.slot_free?('4')
test_board.print
