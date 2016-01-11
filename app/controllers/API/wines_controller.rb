class API::WinesController < ApplicationController
	skip_before_action :verify_authenticity_token

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
		@wine = Wine.find(params[:id])
		@wine.name = params[:name] if params[:name]
		@wine.vineyard = params[:vineyard] if params[:vineyard]
		@wine.description = params[:description] if params[:description]
		@wine.save!
	    render json: @wine
	end

	private

 	def wine_params
 	  params.permit(:id, :name, :vineyard, :description)
 	end
end