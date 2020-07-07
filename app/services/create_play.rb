class CreatePlay
  def self.perform(*args, &block)
    new(*args, &block).perform
  end

  def initialize(params)
    @play = Play.new
    @play.images.attach(params[:images])
  end

  def perform
    return OpenStruct.new(success?: true, play: @play) if @play.save
    OpenStruct.new(success?: false, errors: @play.errors.messages)
  end
end
