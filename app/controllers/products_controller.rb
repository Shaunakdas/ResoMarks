class ProductsController < ApplicationController
	def index
    @reference_scores = ExamReferenceScore.all
  end
end
