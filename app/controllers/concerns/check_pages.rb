module CheckPages
  extend ActiveSupport::Concern

  included do
    before_action :check_for_current_page
  end

  #######
  private
  #######

  def check_for_current_page
    render_not_found and return unless pages_list.include?(params[:page].to_s)
  end

  def pages_list
    @_pages_list ||= Dir.glob(File.join(Rails.root, 'app', 'views', 'pages', '*.*')).map{ |s| File.basename(s, ".html.erb") }
  end

end
