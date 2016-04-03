class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks, primary_key: :id do |t|
      t.string :task_type, limit: 63, default: nil
      t.string :task_description, limit: 255
      t.datetime :starts_at, default: nil
      t.datetime :ends_at, default: nil
      t.string :assignment_title, limit: 255, default: nil
      t.string :course_title, limit: 255, default: nil
      t.string :organization_title, limit: 255, default: nil
      t.string :owner_name, limit: 255, default: nil
      t.string :cip_level1_code, limit: 255, default: nil
      t.string :cip_level2_code, limit: 255, default: nil
      t.string :cip_level3_code, limit: 255, default: nil
      t.string :app_name, limit: 255, default: nil
      t.timestamps null: false
    end
    change_column :tasks, :id, :string, limit: 20
  end

  def self.down
  	drop_table :tasks
  end
end
