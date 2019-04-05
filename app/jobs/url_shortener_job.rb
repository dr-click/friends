class UrlShortenerJob < ApplicationJob
  queue_as :shortener
  attr_accessor :member

  def perform(member_id)
    @member = Member.find(member_id)
    url_shortener
  end

  #######
  private
  #######

  def url_shortener
    url = Google::UrlShortener.shorten!(member.original_website)
    member.update_attribute(:website, url)
  end
end