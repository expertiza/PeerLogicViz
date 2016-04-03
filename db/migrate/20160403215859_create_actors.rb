class CreateActors < ActiveRecord::Migration
  def self.up
    create_table :actors, primary_key: :id do |t|
      t.string :role, limit: 63, default: nil
      t.timestamps null: false
    end
    change_column :actors, :id, :string, limit: 20
  end

  def self.down
  	drop_table :actors
  end
end
