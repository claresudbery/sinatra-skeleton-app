ENV['APP_ENV'] = 'test'

require "spec_helper"

require_relative '../monstas'
require 'rspec'
require 'rack/test'

RSpec.describe 'The HelloWorld App' do
    include Rack::Test::Methods
  
    def app
      MyApp
    end
  
    it "says hello" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to eq('Hello World')
    end
  
    it "gets basic monstas route successfully" do
      get '/monstas'
      expect(last_response).to be_ok
    end
  
    it "shows a submit button" do
      get '/monstas'
      expect(last_response.body).to include('submit')
    end
  
    it "has a list item" do
      get '/monstas'
      expect(last_response.body).to have_tag(:li)
    end
end