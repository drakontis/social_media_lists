class CreateFederalLegislators < ActiveRecord::Migration
  def change
    create_table :federal_legislators do |t|
      t.integer :person_id, null: false

      t.timestamps
    end

    add_foreign_key :federal_legislators, :people,    column: :person_id, name: 'federal_legislators_person_id_fk'
    add_index       :federal_legislators, :person_id, name: 'federal_legislators_person_idx'
  end
end
