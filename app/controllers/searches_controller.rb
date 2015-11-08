class SearchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create

	def show
		@search = {}
		@search[:location] = params[:location]
		@search[:start_date] = params[:start_date]
		@search[:end_date] = params[:end_date]
		@search[:number_of_cats] = params[:number_of_cats]
	end

	def create
		respond_to do |format|
			format.json { render :json => LitterBox.search(params[:search]) }
			format.html do
				redirect_to search_show_path(params[:search])
			end
		end
	end
end
