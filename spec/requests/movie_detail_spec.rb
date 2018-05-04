require 'rails_helper'

RSpec.describe 'Movie Detail', type: :request do
  let!(:movie) do
    Movie.create(
      title: 'A movie',
      synopsis: 'A silverbird movie',
      genres: 'Action, Adventure',
      casts: 'Eddie Murphy',
      running_time: '1 hr 40 mins',
      release_date: 2.weeks.ago
    )
  end

  describe '/movies/:id' do
    before do
      get "/movies/#{movie.id}"
    end

    it "should have a success status code" do
      expect(response).to have_http_status(200)
    end
      
    it 'should return the correct data' do
      expect(response.body).to eql movie.to_json
    end
  end
end
