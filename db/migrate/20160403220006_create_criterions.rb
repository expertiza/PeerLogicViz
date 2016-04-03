class CreateCriterions < ActiveRecord::Migration
  def change
    create_table :criterions do |t|

      t.timestamps null: false
    end
  end
end
