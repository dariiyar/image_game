class CreatePlay
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(params)
    @play = Play.new
    random_images params
  end

  def perform
    return OpenStruct.new(success?: true, play: @play) if @play.valid?
    OpenStruct.new(success?: false, errors: @play.errors.messages)
  end

  private

  def random_images(params)
    images = params[:images]
    images_count = images.count
    max_images = images_count > 10 ? 10 : images_count
    images.sample(rand(2..max_images)).each do |image|
      @play.images.attach(image)
      @play.save
    end
  end
end
