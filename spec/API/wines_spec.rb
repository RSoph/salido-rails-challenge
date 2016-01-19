require "rails_helper"

RSpec.describe API::WinesController, :type => :controller do

  describe "GET #show" do
    before(:each) do
      @uri = URI('http://localhost:3000/api/wines/5')
      @response = Net::HTTP.get_response(@uri)
      @wine = JSON.parse(@response.body)
    end

    it "GET request is successful" do
      expect(@response.code).to eq("200")
    end

    it "wine name is displayed" do
      expect(@wine["name"].class).to eq(String)
    end
  end

  describe "GET bad wine" do
    before(:each) do
      id = "notanid"
      @uri = URI("http://localhost:3000/api/wines/#{id}")
      @response = Net::HTTP.get_response(@uri)
    end

    it "gives 404 when an invalid wine is called" do
      expect(@response.code).to eq("404")
    end
  end

  describe "Update" do
    it "should update vineyard" do
      @wine = Wine.create(vineyard: "none")
      expect {
        patch :update, id: @wine, vineyard: "Grape Scott!"
        @wine.reload
      }.to change(@wine, :vineyard).to("Grape Scott!")
    end

    it "should not update rating" do
      @wine = Wine.create(vineyard: "none")
      patch :update, id: @wine, community_rating: 10
      @wine.reload
      rating = @wine["community_rating"].to_s
      expect(rating != 10)
    end
  end

  describe "index" do
    before(:each) do
      @uri = URI('http://localhost:3000/api/wines')
      @response = Net::HTTP.get_response(@uri)
      @wines = JSON.parse(@response.body)
    end

    it "displays an array of wines" do
      expect(@wines.class).to eq(Array)
    end

    it "wine names are displayed" do
      expect(@wines[0]["name"].class).to eq(String)
    end
  end
end