class CreateParticipants < ActiveRecord::Migration
  def self.up
    create_table :participants, primary_key: :id do |t|
      t.string :app_name, limit: 255, default: nil
      t.timestamps null: false
    end
    change_column :participants, :id, :string, limit: 20
  end

  def self.down
  	drop_table :participants
  end
end
