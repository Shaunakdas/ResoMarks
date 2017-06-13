class Api::ReferenceScoresController < ApiController
	def index
		@ref_scores = ExamReferenceScore.all
	end
	def get_only_score
		@ref_scores = ExamReferenceScore.all
	end
end
