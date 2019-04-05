class PageCrawlJob < ApplicationJob
  queue_as :crawl
  attr_accessor :member

  def perform(member_id)
    @member = Member.find(member_id)
    crawl_page
  end

  #######
  private
  #######

  def crawl_page
    Crawlers::PageCrawlerService.new(member).execute
  end
end