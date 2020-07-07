class PlayData
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(play)
    @play = play
  end

  def perform
    OpenStruct.new(success?: true, data: data)
  end

  private

  def data
    data = {}
    data[:play_id] = @play.id
    data[:images] = images_data
    data
  end

  def images_data
    @play.images.each_with_object([]) do |image, arr|
      hash = {}
      hash[:id] = image.id
      hash[:link] = Rails.application.routes.url_helpers.url_for(image)
      arr << hash
    end
  end
end
