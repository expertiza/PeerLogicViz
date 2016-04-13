class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def index
  	#AggregratedPeerReviewGrade.calculate
  	AggregratedPeerReviewGrade.convert_peer_review_results_in_each_task_to_csv
  end
end
