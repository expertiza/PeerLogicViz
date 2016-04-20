class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  	# AggregratedPeerReviewGrade.calculate
  	# AggregratedPeerReviewGrade.convert_peer_review_results_in_each_task_to_csv(['EZ-00005581'])
  	 @actor_id = ['EZ-00005431', 'EZ-00005464']
  	# @actor_id = ['EZ-00005473']
  	@percentage_of_empty_comments, @avg_of_non_empty_comment_length, @report = ResponseFormativeness.calculate_percentage_of_empty_comments_avg_of_non_empty_comment_length_and_readability(@actor_id)
  end
end
