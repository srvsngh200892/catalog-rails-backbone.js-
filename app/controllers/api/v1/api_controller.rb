class Api::V1::ApiController < ApplicationController
  around_filter :catch_errors
  before_action :check_content_type
  respond_to :json

  def index
    render json: {
      code: 200,
      status: 'success',
      message: "Hello #{current_partner.name}, let's Flock together."
    }
  end

  # check important params else return error message with missing params details
  def ensure_params(*req)
    missing = []
    req.flatten.each do |param|
      if params[param].blank?
        missing << param.to_s
      end
    end
    if missing.empty?
      return false
    else
      msg = "Following params are required but missing: " + missing.join(", ")
      render_api_error(11 , 400, 'params', msg)
      return true
    end
  end

  private

  def check_content_type
    if request.method == 'POST' || request.method == 'PATCH'
      unless request.content_type.present? and request.content_type.include?('application/json')
        render_api_error(04, 400, 'request', "Only content type application/json is accepted.  Your content type: #{request.content_type}")
      end
    end
  end

  #genric api error method
  def render_api_error(code, status_code, type = 'error' , message = nil)
    error = {}
    error["code"] = code
    error["type"] = type
    error["message"] = message || API_CONFIG["api.error"][code]
    Rails.logger.info("Rendered API error.  Request: #{request.body.read} \n Responded:\n#{{error: error, status: status_code}}")
    render json: {'error' => error}.to_json, status: status_code
  end


  def catch_errors
    yield
  rescue Exception => e
    Rails.logger.error("Unhandled API Error: #{e.to_s}.  Backtrace:\n#{e.backtrace.join("\n")}")
    Rails.logger.info("Unhandled API Error: #{e.to_s}.  Request: #{request.body.read} \n Backtrace:\n#{e.backtrace.join("\n")}")
    render_api_error(02 , 500, 'server', "API internal error: #{e.to_s}")
  end
end
