require 'lingua/en/readability'

class ResponseFormativeness < ActiveRecord::Base
	# https://github.com/dbalatero/lingua
	# https://en.wikipedia.org/wiki/Flesch%E2%80%93Kincaid_readability_tests
	def self.calculate_percentage_of_empty_comments_avg_of_non_empty_comment_length_and_readability(create_in_task_ids)
		num_of_comments = 0
		num_of_empty_comments = 0
		comments = ''
		create_in_task_ids.each do |create_in_task_id|
			answers_with_distinct_assessee_actor_id = Answer.where(["create_in_task_id in (?)", create_in_task_id]).group(:assessor_actor_id, :assessee_actor_id)
			answers_with_distinct_assessee_actor_id.each_with_index do |answer, index|
			answers_for_certain_artifact = Answer.where(assessor_actor_id: answer.assessor_actor_id,
														assessee_actor_id: answer.assessee_actor_id,
														create_in_task_id: answer.create_in_task_id)
				answers_for_certain_artifact.each do |a|
					criterion = Criterion.find(a.criterion_id)
					if criterion and (criterion.type == 'Rating' or criterion.type == 'TextualFeadback')
						num_of_comments += 1
						if a.comment.nil?
							num_of_empty_comments += 1
						else
							comments += (a.comment + ' ')
						end
					end
				end
			end
		end
		@report = Lingua::EN::Readability.new(comments)
		@percentage_of_empty_comments = (100.0 * num_of_empty_comments / num_of_comments).round(2)
		@avg_of_non_empty_comment_length = (1.0 * @report.num_words / (num_of_comments - num_of_empty_comments)).round(2)
		return @percentage_of_empty_comments, @avg_of_non_empty_comment_length, @report
	end
end