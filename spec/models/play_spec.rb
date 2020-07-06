require 'rails_helper'

RSpec.describe Play, type: :model do
  describe 'Upload images' do
    subject { FactoryBot.create(:play).images }
    it { is_expected.to be_an_instance_of(ActiveStorage::Attached::Many) }
  end
end
