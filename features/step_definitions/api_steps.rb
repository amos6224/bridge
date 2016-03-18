When /^a client requests POST "(.*?)" with the following json:$/ do |path, body|
  header 'Content-Type', 'application/json'
  @last_response = post path, body.gsub("\n", "")
end

Then /^the response status should be "(.*?)"$/ do |status|
  expect(@last_response.status).to eq status.to_i
end

Then /^the JSON body should be:$/ do |json|
  expect(
    JSON.parse(@last_response.body)
  ).to eq(
    JSON.parse(json)
  )
end
