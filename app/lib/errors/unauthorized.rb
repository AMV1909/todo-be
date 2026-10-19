module Errors
  class Unauthorized < BaseError
    def initialize(message = "You need yo sign in to continue")
      super
    end

    def status
      :unauthorized # 401
    end
  end
end
