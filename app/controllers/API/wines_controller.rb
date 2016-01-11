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

end