require 'spec_helper'
require_relative "../lib/request"

RSpec.describe 'Parser' do

  it "parses the verb" do
    input = [
      "POST /widgets/1/edit?some-id=42&some-other-id=other HTTP/1.1",
      "Host: localhost:3000",
      "Cache-Control: no-cache",
      "Content-Type: application/x-www-form-urlencoded",
      "",
      "first_name=Alex&last_name=Andrews"
    ].join("\n")

    request = Request.new(input)
    request.parse

    # get the body
    expect(request.body).to eq("first_name=Alex&last_name=Andrews")

    # get things from the request line
    expect(request.verb).to eq("POST")
    expect(request.path).to eq("/widgets/1/edit")
    expect(request.query_string).to eq("some-id=42&some-other-id=other")

    # parse the headers
    expect(request.headers).to eq({
      "Host" => "localhost:3000",
      "Cache-Control" => "no-cache",
      "Content-Type" => "application/x-www-form-urlencoded",
    })

    # bring together all the params
    expect(request.params).to eq({
      "some-id" => "42",
      "some-other-id" => "other",
      "first_name" => "Alex",
      "last_name" => "Andrews",
    })

  end

end
