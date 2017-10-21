class CreatePeopleCustomLists < ActiveRecord::Migration
  def change
    create_table :people_custom_lists do |t|
      t.integer :person_id,      null: false
      t.integer :custom_list_id, null: false
    end

    add_foreign_key :people_custom_lists, :people, column: :person_id, name: 'people_custom_lists_person_fk'
    add_index       :people_custom_lists, :person_id, name: 'people_custom_lists_person_idx'

    add_foreign_key :people_custom_lists, :custom_lists, column: :custom_list_id, name: 'people_custom_lists_custom_list_fk'
    add_index       :people_custom_lists, :custom_list_id, name: 'people_custom_lists_custom_list_idx'

    add_index       :people_custom_lists, [:person_id, :custom_list_id], unique: true, name: 'people_custom_lists_person_custom_list_uidx'
  end
end
