class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.integer  :person_id, null: false
      t.text     :body,      null: false
      t.datetime :posted_at, null: false

      t.timestamps
    end

    add_foreign_key :posts, :people,    column: :person_id, name: 'posts_person_id_fk'
    add_index       :posts, :person_id, name: 'posts_person_idx'
  end
end
