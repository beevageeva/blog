class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.string :title
      t.text :description
      t.text :content
      t.references :user
      t.references :category

      t.timestamps
    end
    add_index :posts, :category_id
  end
end
