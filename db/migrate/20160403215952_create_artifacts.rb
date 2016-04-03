class CreateArtifacts < ActiveRecord::Migration
  def self.up
    create_table :artifacts, primary_key: :id do |t|
      t.text :content, default: nil
      t.text :elaboration, default: nil
      t.string :submitted_in_task_id, limit: 20
      t.string :context_case, limit: 255, default: nil
      t.timestamps null: false
    end
    change_column :artifacts, :id, :string, limit: 20
  end

  def self.down
  	drop_table :artifacts
  end
end
