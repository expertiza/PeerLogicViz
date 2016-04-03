class CreateEvalModes < ActiveRecord::Migration
  def change
    create_table :eval_modes do |t|

      t.timestamps null: false
    end
  end
end
