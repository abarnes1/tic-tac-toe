require_relative '../lib/tictactoe'

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
end