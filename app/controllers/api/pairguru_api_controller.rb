module API
  class PairguruApiController < ApplicationController
    include HTTParty
    base_uri "pairguru-api.herokuapp.com"

    def description(title)
      self.class.get("/api/v1/movies/#{title}")["data"]["attributes"]["plot"]
    end

    def image_url(title)
      "https://pairguru-api.herokuapp.com" + self.class.get("/api/v1/movies/#{title}")["data"]["attributes"]["poster"]
    end

    def rating(title)
      self.class.get("/api/v1/movies/#{title}")["data"]["attributes"]["rating"]
    end

  end
end
