ActiveRecord::Schema.define do
  self.verbose = false

  create_table :addresses, id:false, force: true do |t|
    t.string :id#, null: false
    t.index  :id, unique: true
    t.string :street
    t.string :city
    t.string :state
    t.string :zip
    t.timestamps
  end
end
