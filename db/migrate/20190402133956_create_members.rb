class CreateMembers < ActiveRecord::Migration[5.2]
  def change
    create_table :members do |t|
      t.string :website
      t.string :original_website
      t.string :name

      t.timestamps
    end
  end
end
