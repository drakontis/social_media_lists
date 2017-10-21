class CreateSocialNetworks < ActiveRecord::Migration
  def change
    create_table :social_networks do |t|
      t.string :name, null: false

      t.timestamps
    end

    add_index :social_networks, :name, unique: true, name: 'social_networks_name_uidx'
  end
end
