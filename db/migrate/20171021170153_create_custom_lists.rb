class CreateCustomLists < ActiveRecord::Migration
  def change
    create_table :custom_lists do |t|
      t.string :name, null: false
    end

    add_index :custom_lists, :name, unique: true, name: 'custom_lists_name_uidx'
  end
end