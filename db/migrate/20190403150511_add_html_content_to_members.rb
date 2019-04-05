class AddHtmlContentToMembers < ActiveRecord::Migration[5.2]
  def change
    add_column :members, :html_content, :text
  end
end
