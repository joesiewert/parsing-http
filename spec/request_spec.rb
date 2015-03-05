require 'spec_helper'
require_relative '../lib/parse_request.rb'

RSpec.describe 'Request' do

  before(:all) do
    input = [
      "POST /widgets/1/edit?some-id=42&some-other-id=other HTTP/1.1",
      "Host: localhost:3000",
      "Cache-Control: no-cache",
      "Content-Type: application/x-www-form-urlencoded",
      "",
      "first_name=Alex&last_name=Andrews"
    ].join("\n")

    @request = Request.new(input)
  end

  it 'returns the verb' do
    expect(@request.verb).to eq('POST')
  end

  it 'returns the path' do
    expect(@request.path).to eq('/widgets/1/edit?some-id=42&some-other-id=other')
  end

  it 'returns the version' do
    expect(@request.version).to eq('HTTP/1.1')
  end

  it 'returns the query string' do
    expect(@request.query_string).to eq('some-id=42&some-other-id=other')
  end

  it 'returns the headers' do
    expect(@request.headers).to eq({
      "Host" => "localhost:3000",
      "Cache-Control" => "no-cache",
      "Content-Type" => "application/x-www-form-urlencoded"
    })
  end

  it 'returns the params' do
    expect(@request.params).to eq({
      "some-id" => "42",
      "some-other-id" => "other",
      "first_name" => "Alex",
      "last_name" => "Andrews"
    })
  end

end
