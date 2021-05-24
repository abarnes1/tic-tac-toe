# frozen_string_literal: true

class ComputerPlayer
  attr_reader :marker, :color_code

  def initialize(marker, color_code = nil)
    @marker = marker
    @color_code = color_code
  end
end
