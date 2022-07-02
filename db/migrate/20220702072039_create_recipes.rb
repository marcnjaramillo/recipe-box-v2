class CreateRecipes < ActiveRecord::Migration[7.0]
  def change
    create_table :recipes do |t|
      t.string      :name,                  null: false
      t.string      :prep_time,             null: false
      t.string      :cook_time,             null: false
      t.string      :category,              null: false
      t.string      :difficulty,            null: false
      t.string      :cuisine,               null: false
      t.text        :directions,            null: false
      t.integer     :total_likes_count,     default: 0
      t.integer     :total_comments_count,  default: 0
      t.references  :user
      t.timestamps
    end
  end
end
