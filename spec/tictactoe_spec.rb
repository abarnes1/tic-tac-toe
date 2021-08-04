require_relative '../lib/tictactoe'

describe TicTacToe do
  describe '#ask_player_type' do
    context 'when input is valid' do
      # loop ends
    end

    context 'when input is invalid' do
      # loop continues until not valid
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