class Api::AnalyticsController < ApiController
	def trial
		response ={}
	    attempted =  0
	    response["attempted"]||={}
	    response["number"] = params[:number]
	    render json: response.to_json, status: 200
	end
end
