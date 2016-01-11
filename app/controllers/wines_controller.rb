class WinesController < ApplicationController

	def index
		@wines = Wine.all
	end

	def show
		@wine = Wine.find(params[:id])
	end

	def new
		@wine = Wine.new
	end

	def create
		@wine = Wine.create(wine_params)
		redirect_to wines_path
	end

	def edit
		@wine = Wine.find(params[:id])
	end

	def update
		@wine = Wine.find(params[:id])
		@wine.update(name: params["wine"]["name"])
		@wine.update(vineyard: params["wine"]["vineyard"])
		@wine.update(description: params["wine"]["description"])
		redirect_to wines_path
	end

	def destroy
		@wine = Wine.find(params[:id])
		@wine.destroy
		redirect_to wines_path
	end

	private

	def wine_params
      params.require(:wine).permit(:name, :community_rating, :vineyard, :description)
    end
end
