require 'spec_helper'
require_relative '../lib/parse_response.rb'

RSpec.describe 'Response' do

  before(:all) do
    input = [
      "HTTP/1.1 200 OK",
      "Server: nginx/1.4.6 (Ubuntu)",
      "Date: Tue, 06 May 2014 02:17:16 GMT",
      "Content-Type: text/html",
      "Last-Modified: Sun, 27 Apr 2014 04:03:41 GMT",
      "Transfer-Encoding: chunked",
      "Connection: keep-alive",
      "Content-Encoding: gzip",
      "",
      "<!DOCTYPE html>",
      "<html lang='en'>",
      "<head><meta charset='utf-8' />",
        "<title>Should I Test Private Methods?</title>",
      "</head>",
      "<body>",
        "<div style='font-size: 96px; font-weight: bold; text-align: center; padding-top: 200px; font-family: Verdana, Helvetica, sans-serif'>NO</div>",
      "</body>",
      "</html>"
    ].join("\n")

    @response = Response.new(input)
  end

  it 'returns the version' do
    expect(@response.version).to eq('HTTP/1.1')
  end

  it 'returns the status' do
    expect(@response.status).to eq('200')
  end

  it 'returns the headers' do
    expect(@response.headers).to eq({
      "Server" => "nginx/1.4.6 (Ubuntu)",
      "Date" => "Tue, 06 May 2014 02:17:16 GMT",
      "Content-Type" => "text/html",
      "Last-Modified" => "Sun, 27 Apr 2014 04:03:41 GMT",
      "Transfer-Encoding" => "chunked",
      "Connection" => "keep-alive",
      "Content-Encoding" => "gzip"
    })
  end

  it 'returns the body' do
    expect(@response.body).to eq("<!DOCTYPE html><html lang='en'><head><meta charset='utf-8' /><title>Should I Test Private Methods?</title></head><body><div style='font-size: 96px; font-weight: bold; text-align: center; padding-top: 200px; font-family: Verdana, Helvetica, sans-serif'>NO</div></body></html>")
  end

end
