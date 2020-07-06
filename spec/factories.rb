FactoryBot.define do
  factory :play do
    timer { rand(10) }
    after(:build) do |play|
      play.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'image_1.jpeg')), filename: 'image_1.jpeg', content_type: 'image/jpeg')
      play.images.attach(io: File.open(Rails.root.join('spec', 'fixtures', 'images', 'image_1.jpeg')), filename: 'image_2.jpeg', content_type: 'image/jpeg')
    end
  end
end
