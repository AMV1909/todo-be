module Errors
  class Forbidden < BaseError
    def initialize(message = "You are not allowed to perform this action")
      super
    end

    def status
      :forbidden # 403
    end
  end
end
