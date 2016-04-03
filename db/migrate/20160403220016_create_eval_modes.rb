class CreateEvalModes < ActiveRecord::Migration
  def self.up
    create_table :eval_modes do |t|
      t.string :description, limit: 255, default: nil
      t.timestamps null: false
    end
  end

  def self.down
  	drop_table :eval_modes
  end
end
