require "csv"

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

	def self.convert_peer_review_results_in_each_task_to_csv(create_in_task_ids)
		assessee_actor_ids = Array.new
		assessor_actor_ids = Array.new
		peer_review_matrix = Hash.new
		create_in_task_ids.each do |create_in_task_id|
			peer_review_results = AggregratedPeerReviewGrade.where(create_in_task_id: create_in_task_id)
			peer_review_results.each do |result|
				assessee_actor_ids << result.assessee_actor_id unless assessee_actor_ids.include? result.assessee_actor_id
				@participant_id = ActorParticipant.where(actor_id: result.assessor_actor_id).first.participant_id
				assessor_actor_ids << @participant_id unless assessor_actor_ids.include? @participant_id
				peer_review_matrix[result.assessee_actor_id] = Hash.new unless peer_review_matrix.has_key?(result.assessee_actor_id)
				peer_review_matrix[result.assessee_actor_id][@participant_id] = result.aggregrated_peer_review_grade
			end
		end
		assessor_actor_ids.sort!
		assessee_actor_ids.sort!

		file_name = ''
		create_in_task_ids.each_with_index do |id, index| 
			file_name += id
			file_name += '-' if index != create_in_task_ids.length - 1
		end

		CSV.open("#{file_name}.csv", "wb") do |csv|
		  #csv << ["animal", "count", "price"]
		  #csv << ["fox", "1", "$90.00"]
		  assessor_actor_ids.unshift(nil)
		  csv << assessor_actor_ids
		  assessor_actor_ids.delete_at(0)
		  assessee_actor_ids.each do |assessee_actor_id|
	  		temp_array = Array.new
	  		temp_array << assessee_actor_id
		  	assessor_actor_ids.each do |assessor_actor_id|
		  		if peer_review_matrix[assessee_actor_id].has_key? assessor_actor_id
		  			temp_array << peer_review_matrix[assessee_actor_id][assessor_actor_id]
		  		else
		  			temp_array << nil
		  		end
		  	end
		  	csv << temp_array
		  end
		end
	end
end
