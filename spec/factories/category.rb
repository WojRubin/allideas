FactoryBot.define do
  factory :category do
    name { Faker::Lorem.word }
    category_details {{"1556181010342"=>{"field_name"=>"New?", "field_type"=>"select", "field_data"=>["yes", "not"]}, "1556181110274"=>{"field_name"=>"color", "field_type"=>"select", "field_data"=>["red", "blue", "black"]} }}
  end
end

