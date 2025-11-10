class CreateBlogEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :blog_entries do |t|
      t.string :title
      t.text :content
      t.string :author

      t.timestamps
    end
  end
end
