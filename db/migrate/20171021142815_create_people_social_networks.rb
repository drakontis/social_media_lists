class CreatePeopleSocialNetworks < ActiveRecord::Migration
  def change
    create_table :people_social_networks do |t|
      t.integer :person_id,                null: false
      t.integer :social_network_id,        null: false
      t.string  :person_social_network_id, null: false

      t.timestamps
    end

    add_foreign_key :people_social_networks, :people,    column: :person_id, name: 'people_social_networks_person_id_fk'
    add_index       :people_social_networks, :person_id, name: 'people_social_networks_person_idx'

    add_foreign_key :people_social_networks, :social_networks,   column: :social_network_id, name: 'people_social_networks_social_network_id_fk'
    add_index       :people_social_networks, :social_network_id, name: 'people_social_networks_social_network_idx'

    add_index       :people_social_networks, [:person_id, :social_network_id], unique: true, name: 'people_social_networks_person_social_network_uidx'
  end
end
