require_relative '../lib/gameboard'

describe Gameboard do
  describe '#open_spaces' do
    context 'when game is 3x3' do
      subject(:nine_space_game) { described_class.new(3) }

      context 'when no spaces are marked' do
        it 'has 9 open spaces' do
          open_spaces = nine_space_game.open_spaces
          expect(open_spaces.count).to eq(9)
        end
      end
    end

    context 'when game is 10x10' do
      subject(:hundred_space_game) { described_class.new(10) }

      context 'when no spaces are marked' do
        it 'has 100 open spaces' do
          open_spaces = hundred_space_game.open_spaces
          expect(open_spaces.count).to eq(100)
        end
      end
    end
  end

  describe '#mark' do
    context 'when game is 3x3' do
      subject(:marked_game) { described_class.new(3) }

      context 'when space 1 is marked' do
        before do
          marked_game.mark(1, 'X')
        end

        it 'has 8 open spaces' do
          open_spaces = marked_game.open_spaces

          expect(open_spaces.count).to eq(8)
        end

        it 'does not include 1 as open' do
          open_spaces = marked_game.open_spaces

          expect(open_spaces).not_to include(1)
        end

        it 'includes spaces 2-9 as open' do
          open_spaces = marked_game.open_spaces
          expected_open_spaces = (2..9).to_a

          expect(open_spaces).to eq(expected_open_spaces)
        end
      end

      context 'when spaces 1, 5, and 9 are marked' do
        before do
          marked_game.mark(1, 'X')
          marked_game.mark(5, 'X')
          marked_game.mark(9, 'X')
        end

        it 'has 6 open spaces' do
          open_spaces = marked_game.open_spaces

          expect(open_spaces.count).to eq(6)
        end

        it 'does not include 1, 5, and 9 as open' do
          open_spaces = marked_game.open_spaces

          expect(open_spaces).not_to include(1, 5, 9)
        end

        it 'includes spaces 2-9 as open' do
          open_spaces = marked_game.open_spaces
          expected_open_spaces = (1..9).to_a - [1, 5, 9]

          expect(open_spaces).to eq(expected_open_spaces)
        end
      end
    end
  end
end
