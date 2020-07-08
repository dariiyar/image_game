class PlaysController < ApplicationController
  def game
    @plays = Play.all
  end

  def images
    service = CreatePlay.perform(play_params)
    if service.success?
      render json: PlayData.perform(service.play).data, status: :created
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  private

  def play_params
    params.require(:play).permit(images: [])
  end
end
