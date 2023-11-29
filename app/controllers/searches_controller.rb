class SearchesController < ApplicationController
  before_action :get_current_user

  def search
    @word = params[:word]
    @results = Room.search(@word)
  end

  def search_by_area
    @area = params[:area]
    @results = Room.search_by_area(@area)
  end

  private
  def get_current_user
    @user = current_user
  end

end
