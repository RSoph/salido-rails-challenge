class API::WinesController < ApplicationController

	def index
		@wines = Wine.all
		respond_to do |format|
			format.json {render :json => @wines}
		end
	end

	def show
		@wine = Wine.find(params[:id])
		respond_to do |format|
			format.json {render :json => @wine}
		end
	end

	def update
		@wine = Wine.find(wine_params)
		@wine.update(wine_params)
	    render json: @wine
	end

	private

 	def wine_params
 	  params.require(:wine).permit(:id, :name, :vineyard, :description)
 	end
end