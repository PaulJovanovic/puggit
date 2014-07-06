class TheatresController < ApplicationController
  def show
    @channels = Game.limit(15)
  end
end
