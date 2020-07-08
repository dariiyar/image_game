require 'rails_helper'

RSpec.describe CreatePlay do
  describe '#perform' do
    let(:params) { {} }
    before do
      params[:images] = []
      15.times { params[:images] << fixture_file_upload(Rails.root.join('spec', 'fixtures', 'images', 'image_1.jpeg'), 'image/png') }
    end
    subject { described_class.new(params) }

    it 'creates play with images between 2 and 10' do
      expect(subject.perform.play.images.count).to be_between(2, 10)
    end
  end
end
