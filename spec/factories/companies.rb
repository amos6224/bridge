FactoryGirl.define do

  sequence :permalink do |n|
    "permalink_#{n}"
  end

  factory :company do
    permalink
  end
end
