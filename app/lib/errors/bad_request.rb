module Errors
  class BadRequest < BaseError
    def status
      :bad_request # 400
    end
  end
end
