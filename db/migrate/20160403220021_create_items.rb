class CreateItems < ActiveRecord::Migration
  def self.up
    create_table :items, primary_key: :id do |t|
      t.text :content, default: nil
      t.string :reference_id, limit: 20, default: nil
      t.string :type, limit: 63, default: nil
      t.timestamps null: false
    end
    change_column :items, :id, :string, limit: 20, default: nil
  end

  def self.down
  	drop_table :items
  end
end
