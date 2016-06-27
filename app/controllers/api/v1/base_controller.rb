class Api::V1::BaseController < ApplicationController
  rescue_from Exception do |e|
    api_error(500, BaseApiError.new(e.message))
  end

  rescue_from TokenAuth::Unauthorized do |e|
    api_error(401, BaseApiError.new(e.message, 401))
  end

  rescue_from ActiveRecord::RecordInvalid do |e|
    api_error(422, ValidationApiError.new(e.record.errors))
  end

  def api_error(status = 500, error = nil)
    render json: error.serialize, status: status
  end
end
