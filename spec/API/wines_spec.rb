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

    it "wine name as expected" do
      expect(@wine["name"]).to eq("Duckhorn Vineyards Wine Trio")
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
  end

    describe "index" do
    before(:each) do
      @uri = URI('http://localhost:3000/api/wines')
      @response = Net::HTTP.get_response(@uri)
      @wines = JSON.parse(@response.body)
    end

    it "wine names are displayed" do
      expect(@wines[0]["name"]).to eq("90+ Point Red Wine Trio")
    end
  end
end