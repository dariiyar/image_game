require 'rails_helper'

RSpec.describe PlayData do
  describe '#perform' do
    let(:play) { FactoryBot.create(:play) }
    subject { described_class.new(play) }
    it "creates play's data" do
      data = subject.perform.data
      expect(data[:play_id]).to eq(play.id)
      expect(data[:images].count).to eq(2)
    end
  end
end
