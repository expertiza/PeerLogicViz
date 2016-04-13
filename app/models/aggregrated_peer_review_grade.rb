class AggregratedPeerReviewGrade < ActiveRecord::Base
	def self.calculate
		iterator = 1
		answers_with_distinct_assessee_actor_id = Answer.group(:assessor_actor_id, :assessee_actor_id, :create_in_task_id)
		answers_with_distinct_assessee_actor_id.each_with_index do |answer, index|
			answers_for_certain_artifact = Answer.where(assessor_actor_id: answer.assessor_actor_id,
														assessee_actor_id: answer.assessee_actor_id,
														create_in_task_id: answer.create_in_task_id)
			total_score_for_one_rubric = 0
			peer_review_grade = 0
			answers_for_certain_artifact.each do |a|
				criterion = Criterion.find(a.criterion_id)
				if criterion and criterion.type == 'Rating' and !a.score.nil?
					weight = (criterion.weight ||= 1)
					total_score_for_one_rubric += criterion.max_score * weight
					peer_review_grade += a.score * weight
				end
			end
			if total_score_for_one_rubric != 0
				aggregrated_peer_review_grade = 100.0 * peer_review_grade / total_score_for_one_rubric
			else
				aggregrated_peer_review_grade = 0
			end
			AggregratedPeerReviewGrade.create(
											   id: iterator,
											   assessor_actor_id: answer.assessor_actor_id, 
											   assessee_actor_id: answer.assessee_actor_id, 
											   create_in_task_id: answer.create_in_task_id, 
											   aggregrated_peer_review_grade: aggregrated_peer_review_grade)
			iterator += 1
			print '.' if index % 100 == 0
		end
	end
end
