require 'nokogiri'
require 'restclient'

module Crawlers
  class PageCrawlerService < ::BaseService
    attr_reader :member, :site_url, :page, :required_contents

    REQUIRED_TAGS = ["h1", "h3"]

    def initialize(user)
      @member = user
      @site_url = member.original_website
      @required_contents = []
    end

    def _execute
      crawl_page
      parse_crawl_page
      update_member_html_content
    end

    #######
    private
    #######

    def crawl_page
      @page = Nokogiri::HTML(RestClient.get(site_url))
    end

    def parse_crawl_page
      parse_content(@page)
    end

    def parse_content(content)
      if REQUIRED_TAGS.include?(content.name.downcase)
        @required_contents << content.content
      elsif content.children.any?
        content.children.each do |child|
          parse_content(child)
        end
      end
    end

    def update_member_html_content
      member.update_attribute(:html_content, required_contents.join(", ")) if required_contents.any?
    end
  end
end