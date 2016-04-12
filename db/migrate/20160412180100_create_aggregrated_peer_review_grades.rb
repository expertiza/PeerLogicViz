class CreateAggregratedPeerReviewGrades < ActiveRecord::Migration
  def self.up
    create_table :aggregrated_peer_review_grades do |t|
      t.string :assessor_actor_id, limit: 20
      t.string :assessee_actor_id, limit: 20, default: nil
      t.string :create_in_task_id, limit: 20, default: nil
      t.float :aggregrated_peer_review_grade, default: nil
    end
  end

  def self.down
  	drop_table :aggregrated_peer_review_grades
  end
end
