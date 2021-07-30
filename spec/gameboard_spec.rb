require_relative '../lib/gameboard.rb'

describe Gameboard do
  describe '#open_spaces' do
    context 'when game is 3x3' do
      let(:nine_space_game) { described_class.new(3) }

      context 'when no spaces are marked' do
        it 'has 9 open spaces' do
          open_spaces = nine_space_game.open_spaces
          expect(open_spaces.count).to eq(9)
        end
      end

      context 'when one space is marked' do
        it 'has 8 open spaces' do
          nine_space_game.mark(1, 'X')
          open_spaces = nine_space_game.open_spaces
          expect(open_spaces.count).to eq(8)
        end
      end

      context 'when 9 slots are marked' do
        it 'has 0 open slots' do
          9.times do |index|
            nine_space_game.mark(index + 1, 'X')
          end

          open_spaces = nine_space_game.open_spaces
          expect(open_spaces.count).to eq(0)
        end
      end
    end

    context 'when game is 10x10' do
      subject(:hundred_space_game) { described_class.new(10) }

      it 'starts 100 open slots' do
        open_spaces = hundred_space_game.open_spaces
        expect(open_spaces.count).to eq(100)
      end
    end
  end
end