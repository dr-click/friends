module Members
  class SearchService < ::BaseService
    attr_reader :search_keyword, :members

    def initialize(keyword)
      @search_keyword = keyword
      @members = Member.order("created_at desc")
    end

    def _execute
      search_by_keyword
      members
    end

    #######
    private
    #######

    def search_by_keyword
      unless search_keyword.blank?
        @members = @members.search(search_keyword)
      end
    end

  end
end