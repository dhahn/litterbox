class SearchesController < ApplicationController
  skip_before_filter :verify_authenticity_token, :only => :create
  before_action :set_page_title

	def show
		@search = {}
		@search[:location] = params[:location]
		@search[:start_date] = params[:start_date]
		@search[:end_date] = params[:end_date]
		@search[:radius] = params[:radius]

		@filters = {}
	end

	def create
		respond_to do |format|
			format.json { render :json => LitterBox.search(params[:search]) }
			format.html do
				redirect_to search_show_path(params[:search])
			end
		end
	end

	private

  def set_page_title
    @page_title = 'Litterbox - Search'
  end
end
