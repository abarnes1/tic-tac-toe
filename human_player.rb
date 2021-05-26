# frozen_string_literal: true

require_relative 'player'

class HumanPlayer < Player
  def initialize(marker, color_code = nil)
    super(marker, color_code)
  end
end
