module Errors
  class NotFound < BaseError
    def initialize(message = "Record not found")
      super
    end

    def status
      :not_found # 404
    end
  end
end
