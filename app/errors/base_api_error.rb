class BaseApiError < ApiError
  def initialize(message, code = nil)
    @base = [{ message: message, code: code }]
  end
end
