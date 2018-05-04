require 'rails_helper'

RSpec.describe 'Movies list', type: :request do
  before do
    Movie.create(
      title: 'A movie',
      synopsis: 'A silverbird movie',
      genres: 'Action, Adventure',
      casts: 'Eddie Murphy',
      running_time: '1 hr 40 mins',
      release_date: 2.weeks.ago
    )
    Movie.create(
      title: 'Another movie',
      synopsis: 'Another movie',
      genres: 'Horror',
      running_time: '2 hr 10 mins',
      release_date: 1.month.ago
    )
  end
  describe '/movies' do
    before do
      get '/movies'
    end

    it "should have a success status code" do
      expect(response).to have_http_status(200)
    end

    it "should return all 2 movies in the response" do
      expect(JSON.parse(response.body).count).to eql 2
    end
      
    it 'should return the correct data' do
      expect(JSON.parse(response.body)[0]['title']).to eql 'A movie'
    end
  end
end
