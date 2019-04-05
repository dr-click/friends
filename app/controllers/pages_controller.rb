class PagesController < ApplicationController
  include CheckPages

  def show
    render template: "pages/#{params[:page]}"
  end

end
