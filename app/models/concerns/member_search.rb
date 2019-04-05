module MemberSearch
  extend ActiveSupport::Concern

  included do
    include PgSearch

    pg_search_scope(
      :search,
      against: %i(html_content)
    )
  end

end
