FactoryBot.define do
  factory :product do
    name { Faker::Lorem.word }
    category
    product_details {{"1556181010342"=>"yes", "1556181110274"=>"red"}}
  end
end