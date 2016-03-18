Given /^companies exist with the following permalinks: (.*)$/ do |permalinks|
  permalinks.split(", ").each do |permalink|
    FactoryGirl.create(:company, permalink: permalink)
  end
end
