class ValidationApiError < ApiError
  def initialize(errors)
    @attributes = errors.messages.inject({}) do |attribute, item|
      attribute[item[0]] = item[1].map { |msg| { message: msg } }
      attribute
    end
  end
end
