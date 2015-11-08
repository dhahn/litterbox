class StaticPagesController < ApplicationController
  def index
    flash[:notice] = "mahsolano soooo hungry"
  end
  def faq
  end
end