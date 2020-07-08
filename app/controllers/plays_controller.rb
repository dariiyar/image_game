class PlaysController < ApplicationController
  protect_from_forgery except: :finish

  def game
    @plays = Play.all.order(updated_at: :desc)
  end

  def images
    service = CreatePlay.perform(play_params)
    if service.success?
      render json: PlayData.perform(service.play).data, status: :created
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  def finish
    service = FinishPlay.perform(params)
    if service.success?
      render json: service.data, status: :ok
    else
      render json: { errors: service.errors }, status: :unprocessable_entity
    end
  end

  private

  def play_params
    params.require(:play).permit(images: [])
  end
end
