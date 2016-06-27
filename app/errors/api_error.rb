class ApiError
  def serialize
    errors = instance_variables.inject({}) do |errors, var|
      errors[var.to_s.gsub(/@/, '')] = instance_variable_get(var)
      errors
    end

    { errors: errors }
  end
end
