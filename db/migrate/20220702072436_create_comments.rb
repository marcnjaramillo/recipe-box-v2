class CreateComments < ActiveRecord::Migration[7.0]
  def change
    create_table :comments do |t|
      t.text        :body,        null: false
      t.references  :user
      t.integer     :parent_id
      t.integer     :nesting
      t.references  :commentable, polymorphic: true
      t.timestamps
    end
  end
end
