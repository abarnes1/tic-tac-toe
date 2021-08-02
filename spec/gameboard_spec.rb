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

        it 'includes spaces 2-4 and 6-8 as open' do
          open_spaces = marked_game.open_spaces
          expected_open_spaces = (1..9).to_a - [1, 5, 9]

          expect(open_spaces).to eq(expected_open_spaces)
        end
      end
    end
  end

  describe '#space_free?' do
    subject(:space_free_game) { described_class.new(3) }

    context 'when space 1 is not marked' do
      it 'is free' do
        expect(space_free_game.space_free?(1)).to be(true)
      end
    end

    context 'when space 1 is marked' do
      before do
        space_free_game.mark(1, 'X')
      end

      it 'is not free' do
        expect(space_free_game.space_free?(1)).not_to be(true)
      end
    end
  end

  describe '#full?' do
    context 'when game is 3x3' do
      subject(:full_test_game) { described_class.new(3) }

      context 'when no spaces are marked' do
        before do
          full_test_game.mark(1, 'X')
        end

        it 'is not full' do
          expect(full_test_game).not_to be_full
        end
      end

      context 'when 5 spaces are marked' do
        before do
          5.times do |index|
            full_test_game.mark(index + 1, 'X')
          end
        end

        it 'is not full' do
          expect(full_test_game).not_to be_full
        end
      end

      context 'when 9 spaces are marked' do
        before do
          9.times do |index|
            full_test_game.mark(index, 'X')
          end
        end

        it 'is full' do
          expect(full_test_game).to be_full
        end
      end
    end
  end

  describe '#marked_spaces' do
    subject(:marked_game) { described_class.new(3) }

    context 'when no spaces marked' do
      it 'returns empty array with specified marker' do
        expect(marked_game.marked_spaces('X')).to be_empty
      end

      it 'returns empty array with no specified marker' do
        expect(marked_game.marked_spaces).to be_empty
      end
    end

    context 'when spaces 1-2 marked X and spaces 3-5 marked O' do
      before do
        marked_game.mark(1, 'X')
        marked_game.mark(2, 'X')
        marked_game.mark(3, 'O')
        marked_game.mark(4, 'O')
        marked_game.mark(5, 'O')
      end

      it 'returns 1 and 2 for X' do
        expected_spaces = [1, 2]
        actual_spaces = marked_game.marked_spaces('X')
        expect(actual_spaces).to eql(expected_spaces)
      end

      it 'returns 3, 4, and 5 for O' do
        expected_spaces = [3, 4, 5]
        actual_spaces = marked_game.marked_spaces('O')
        expect(actual_spaces).to eql(expected_spaces)
      end

      it 'returns 1-5 with no specified marker' do
        expected_spaces = [1, 2, 3, 4, 5]
        actual_spaces = marked_game.marked_spaces
        expect(actual_spaces).to eql(expected_spaces)
      end
    end
  end

  describe '#win_combos' do
    context 'when game is 3x3' do
      subject(:nine_space_game) { described_class.new(3) }
      let(:combos) { nine_space_game.win_combos }

      xit 'has 8 winning combinations' do
        expect(combos.size).to eq(8)
      end

      context 'when win is horizontal' do
        it 'has a [1, 2, 3] win' do
          expect(combos).to include([1, 2, 3])
        end

        it 'has a [4, 5, 6] win' do
          expect(combos).to include([4, 5, 6])
        end

        it 'has a [7, 8, 9] win' do
          expect(combos).to include([7, 8, 9])
        end
      end

      context 'when win is vertical' do
        it 'has a [1, 4, 7] win' do
          expect(combos).to include([1, 4, 7])
        end
  
        it 'has a [2, 5, 8] win' do
          expect(combos).to include([2, 5, 8])
        end
  
        it 'has a [3, 6, 9] win' do
          expect(combos).to include([3, 6, 9])
        end
      end

      context 'when win is diagonal' do
        xit 'has a [1, 5, 9] win' do

        end
  
        xit 'has a [7, 5, 3] win' do
  
        end
      end
    end

    context 'when game is 10x10' do
      subject(:hundred_space_game) { describe_class.new(10) }
    end
  end
end
