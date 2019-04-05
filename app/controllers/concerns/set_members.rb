module SetMembers
  extend ActiveSupport::Concern

  included do
    before_action :set_member, only: [:show, :new, :set_current]
  end

  #######
  private
  #######

  def set_member
    @member = params[:id].blank? ? Member.new : Member.find(params[:id])
  end

  def member_params
    params.require(:member).permit(:original_website, :name)
  end

end
