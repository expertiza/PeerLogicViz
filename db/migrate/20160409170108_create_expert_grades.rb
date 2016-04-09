class CreateExpertGrades < ActiveRecord::Migration
  def self.up
    create_table :expert_grades, id: false do |t|
      t.string :actor_id, limit: 20 # team
      t.float :expert_grade, default: nil
      t.string :assignment_title, limit: 255, default: nil
      t.string :course_title, limit: 255, default: nil
      t.string :organization_title, limit: 255, default: nil
    end
  end

  def self.down
  	drop_table :expert_grades
  end
end
