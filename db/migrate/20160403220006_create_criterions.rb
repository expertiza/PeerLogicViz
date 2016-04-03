class CreateCriterions < ActiveRecord::Migration
  def self.up
    create_table :criterions, primary_key: :id do |t|
      t.text :title
      t.text :description, default: nil
      t.string :type, limit: 63, default: nil
      t.float :min_score, default: nil
      t.float :max_score, default: nil
      t.float :weight, default: nil
      t.timestamps null: false
    end
    change_column :criterions, :id, :string, limit: 20
  end

  def self.down
  	drop_table :criterions
  end
end
