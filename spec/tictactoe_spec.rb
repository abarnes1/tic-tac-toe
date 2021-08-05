require_relative '../lib/tictactoe'
require_relative '../lib/gameboard' # uh oh... bad class design?

describe TicTacToe do
  describe '#ask_player_type' do
    #loop script, make sure ends when appropriate
    subject(:player_type_game) { described_class.new }
    puts_per_loop = 2

    context 'when first input is valid' do
      before do
        valid_input = '1'
        allow(player_type_game).to receive(:puts)
        allow(player_type_game).to receive(:print)
        allow(player_type_game).to receive(:gets).and_return(valid_input)
      end

      it 'stops after one loop' do
        loops = 1
        total_puts = loops * puts_per_loop
        expect(player_type_game).to receive(:puts).exactly(total_puts).times
        player_type_game.ask_player_type('X')
      end
    end

    context 'when input is invalid' do
      context 'when 1 invalid input' do
        before do
          invalid_input = '7'
          valid_input = '1'
          allow(player_type_game).to receive(:puts)
          allow(player_type_game).to receive(:print)
          allow(player_type_game).to receive(:gets).and_return(invalid_input, valid_input)
        end

        it 'stops after the loop after valid (2nd) input' do
          loops = 2
          total_puts = loops * puts_per_loop
          expect(player_type_game).to receive(:puts).exactly(total_puts).times
          player_type_game.ask_player_type('X')
        end
      end

      context 'when 3 invalid inputs' do
        before do
          invalid_1 = '7'
          invalid_2 = 'batman'
          invalid_3 = ''
          valid_input = '1'
          allow(player_type_game).to receive(:puts)
          allow(player_type_game).to receive(:print)
          allow(player_type_game).to receive(:gets).and_return(invalid_1, invalid_2, invalid_3, valid_input)
        end

        it 'stops after the loop after valid (4th) input' do
          loops = 4
          total_puts = loops * puts_per_loop
          expect(player_type_game).to receive(:puts).exactly(total_puts).times
          player_type_game.ask_player_type('X')
        end
      end
    end
  end

  #loop script
  describe '#board_size' do
    subject(:board_size_game) { described_class.new }

    before do
      allow(board_size_game).to receive(:puts)
      allow(board_size_game).to receive(:print)
    end

    context 'when input in 3-15 range' do
      context 'when input is 3' do
        before do
          valid_size = '3'
          allow(board_size_game).to receive(:gets).and_return(valid_size)
        end

        it 'exits the prompt loop' do
          expect(board_size_game).to receive(:print).once
          board_size_game.board_size
        end

        it 'returns 3' do
          expected = 3
          actual = board_size_game.board_size
          expect(expected).to eq(actual)
        end
      end

      context 'when input is 15' do
        before do
          valid_size = '15'
          allow(board_size_game).to receive(:gets).and_return(valid_size)
        end

        it 'exits the prompt loop' do
          expect(board_size_game).to receive(:print).once
          board_size_game.board_size
        end

        it 'returns 15' do
          expected = 15
          actual = board_size_game.board_size
          expect(expected).to eq(actual)
        end
      end
    end

    context 'when input is invalid' do
      context 'when input out of range' do
        before do
          invalid_input = '2'
          valid_input = '3'
          allow(board_size_game).to receive(:gets).and_return(invalid_input, valid_input)
        end

        it 'continues the input loop when input is 2' do
          expect(board_size_game).to receive(:print).twice
          board_size_game.board_size
        end
      end
    end

    context 'when input is blank' do
      before do
        input = ''
        allow(board_size_game).to receive(:gets).and_return(input)
      end

      it 'returns default value of 3' do
        expected = 3
        actual = board_size_game.board_size
        expect(expected).to eq(actual)
      end
    end
  end

  describe '#create_player' do
    subject(:player_select_game) { described_class.new }

    context 'when human is chosen (player type 1)' do
      before do
        allow(player_select_game).to receive(:ask_player_type).and_return('1')
      end

      it 'creates a human player' do
        player = player_select_game.create_player('X')

        expect(player.class).to eq(HumanPlayer)
      end
    end

    context 'when computer is chosen (player type 2)' do
      before do
        allow(player_select_game).to receive(:ask_player_type).and_return('2')
      end

      it 'creates a computer player' do
        player = player_select_game.create_player('X')

        expect(player.class).to eq(ComputerPlayer)
      end
    end
  end

  describe '#switch_player' do
    context 'when player 1 is active' do
      subject(:active_player_game) { described_class.new }
      let(:player1) { double('player1') }
      let(:player2) { double('player2') }

      before do
        allow(active_player_game).to receive(:board_size).and_return(3)
        allow(active_player_game).to receive(:create_player).and_return(player1, player2)
      end

      it 'switches player 1 to player 2' do
        expected = player2

        active_player_game.setup_game
        actual = active_player_game.switch_player

        expect(actual).to be(expected)
      end

      it 'switches player 2 to player 1' do
        expected = player1

        active_player_game.setup_game
        active_player_game.switch_player
        actual = active_player_game.switch_player

        expect(actual).to be(expected)
      end
    end

    # context 'when player 2 is active' do
    # end
  end
end