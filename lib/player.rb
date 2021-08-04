# frozen_string_literal: true

# Parent class for all player types
class Player
  attr_reader :color_code

  def initialize(marker, color_code = nil)
    @marker = marker
    @color_code = color_code
  end

  def marker
    @color_code.nil? ? @marker : "\e[#{@color_code}#{@marker}\e[0m"
  end
end
