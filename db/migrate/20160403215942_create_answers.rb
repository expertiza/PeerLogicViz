class CreateAnswers < ActiveRecord::Migration
  def self.up
    create_table :answers, primary_key: :id do |t|
      t.string :assessor_actor_id, limit: 20
      t.string :assessee_actor_id, limit: 20, default: nil
      t.string :assessee_artifact_id, limit: 20, default: nil
      t.string :criterion_id, limit: 20, default: nil
      t.integer :evaluation_mode_id, limit: 11, default: nil
      t.text :comment, default: nil
      t.text :comment2, default: nil
      t.integer :rank, limit: 11, default: nil
      t.float :score, default: nil
      t.string :create_in_task_id, limit: 20, default: nil
      t.timestamps null: false
    end
    change_column :answers, :id, :string, limit: 20
  end

  def self.down
  	drop_table :answers
  end
end
