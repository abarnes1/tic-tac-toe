require_relative '../lib/gameboard.rb'

describe Gameboard do
  # This is a query message.  I want to change nothing but return something to verify state.
  describe '#open_spaces' do
    context 'when game is 3x3' do
      subject(:nine_space_game) { described_class.new(3) }

      # This test makes sense because #open_spaces can be tested in isolation.
      context 'when no spaces are marked' do
        it 'has 9 open spaces' do
          open_spaces = nine_space_game.open_spaces
          expect(open_spaces.count).to eq(9)
        end
      end

      # This is where it gets fuzzy.  I want to test #open_spaces 
      # under other conditions that requires a space to be marked.  
      # In order to do so I would like to call #mark.

      # 1. Should this be a test on #mark because I send a command 
      #    (#mark) and want to then verify state with a query (#open_spaces)?
      #    Since #open_spaces is a query I'm not sure that I should be 
      #    changing state to test it here.
      #
      #    If I go this route it seems that #mark and #open_spaces 
      #    are necessary to test each other in either case.
      #
      # 2. One option to test #open_spaces in isolation could be to 
      #    allow Gameboard's #initialize to accept an array so I can create
      #    a gameboard with preset spots like this:
      #    ex: predefined_board  = Gameboard.new([ X , nil, nil,
      #                                           nil, nil, nil,
      #                                           nil, nil, nil])
      #
      #    The problem then becomes what if an array is passed that is 
      #    not a square.  Do I add complexity to Gameboard's #initialize
      #    to check for this solely for the ability to create 
      #    Gameboards with predefined spaces for testing? I don't think
      #    there is a need for this behavior outside of this style of testing.
      #
      # 3. Ignore #mark while testing #open_spaces and mark a space by 
      #    accessing Gameboard's internal @spaces array. I could do this
      #    with instance_variable_get(:@spaces).  Another similar option is to
      #    expose @spaces through a public method.  Both of these seem like 
      #    the worst ideas since @spaces should be private and not mutable 
      #    outside of #mark.
      # 
      # 4. Am I overlooking a better approach?
      # 5. Is the current approach good or good enough?

      context 'when space 0 is marked' do
        before do
          nine_space_game.mark(0, 'X')
        end

        it 'has 8 open spaces' do
          open_spaces = nine_space_game.open_spaces

          expect(open_spaces.count).to eq(8)
        end

        it 'does not include 0 as open' do
          open_spaces = nine_space_game.open_spaces

          expect(open_spaces).not_to include(0)
        end

        it 'includes spaces 1-8 as open' do
          open_spaces = nine_space_game.open_spaces
          expected_open_spaces = (1..8).to_a
          
          expect(open_spaces).to eq(expected_open_spaces)
        end
      end
    end
  end
end
