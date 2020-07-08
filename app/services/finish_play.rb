class FinishPlay
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(params)
    @play = Play.find(params[:play])
    @play.update_attribute(:timer, params[:timer])
    @image_id = params[:image]
  end

  def perform
    purge_images
    images = @play.reload.images
    if @play.valid? && images.count == 1
      image_link = Rails.application.routes.url_helpers.rails_blob_path(images.first)
      return OpenStruct.new(success?: true, data: { play_id: @play.id, timer: @play.timer, image_link: image_link })
    end
    OpenStruct.new(success?: false, errors: @play.errors&.messages)
  end

  private

  def purge_images
    @play.images.each do |image|
      if image.id != @image_id.to_i
        image.purge
      end
    end
    @play.save
  end
end
