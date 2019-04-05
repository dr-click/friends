module Renders
  extend ActiveSupport::Concern

  included do
  end

  #######
  private
  #######

  def render_errors(errors)
    respond_to do |format|
      format.html { render(:file => unprocessable_entity_file,  :status => :unprocessable_entity) }
      format.json { render(:json => {:success => false, :error => errors}, status: :unprocessable_entity) }
    end
  end

  def render_unauthorized
    respond_to do |format|
      format.html { render(:file => not_found_file,  :status => :unauthorized) }
      format.json { render(:json=> {:success => false,  :error => "unauthorized"}, :status=>:unauthorized) }
    end
  end

  def render_not_found
    respond_to do |format|
      format.html { render(:file => not_found_file,  :status => :not_found) }
      format.json { render(:json => {:success => false,  :error => "Not Found"}, status: :not_found) }
    end
  end

  def not_found_file
    "#{Rails.root}/public/404.html"
  end

  def unprocessable_entity_file
    "#{Rails.root}/public/422.html"
  end

end
