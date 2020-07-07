require 'rails_helper'

RSpec.describe CreatePlay do
  describe '#perform' do
    let(:params) do
      { images: [fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'image_1.jpeg'), 'image/png'),
                 fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'image_1.jpeg'), 'image/png')] }
    end
    subject { described_class.new(params) }
    it 'creates play' do
      expect(subject.perform.play.images.count).to eq(2)
    end
  end
end
