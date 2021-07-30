# frozen_string_literal: true

require_relative 'player'

# Used to identify computer players
class ComputerPlayer < Player
  def initialize(marker, color_code = nil)
    super(marker, color_code)
  end
end
