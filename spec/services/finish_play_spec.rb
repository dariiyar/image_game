require 'rails_helper'

RSpec.describe FinishPlay do
  describe '#perform' do
    let(:play) { FactoryBot.create(:play) }
    let(:params) do
      {
        play: play.id,
        image: play.images.first.id
      }
    end
    subject { described_class.new(params) }
    it 'purge unselected images' do
      data = subject.perform.data
      expect(Play.find(data[:play_id]).images.count).to eq(1)
      expect(Play.find(data[:play_id]).images.first.id).to eq(params[:image])
    end
  end
end
