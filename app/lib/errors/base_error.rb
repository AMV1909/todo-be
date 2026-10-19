module Errors
  class BaseError < StandardError
    def status
      :internal_server_error
    end

    def details
      nil
    end
  end
end
