class PlaysController < ApplicationController
  def game
    @plays = Play.all
  end

  def images
    service = CreatePlay.perform(params[:play])
    if service.success?
      render json: PlayData.perform(service.play).data, status: :created
    else
      render errors: service.errors, status: :unprocessable_entity
    end
  end
end
