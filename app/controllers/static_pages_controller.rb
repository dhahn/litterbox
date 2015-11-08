class StaticPagesController < ApplicationController
  before_action :set_page_title

  def index
  end
  def faq
  end

  private

  def set_page_title
    @page_title = 'Litterbox - Home'
  end
end
