module MemberSessions
  extend ActiveSupport::Concern

  included do
    before_action :require_member
  end

  #######
  private
  #######

  def require_member
    render_unauthorized and return unless current_member
  end

end
