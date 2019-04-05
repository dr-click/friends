module Members
  class MemberSearchService < SearchService

    #######
    private
    #######

    def search_by_keyword
      unless search_keyword.blank?
        @members = @members.where('name LIKE ?', '%' + search_keyword + '%')

      end
    end

  end
end