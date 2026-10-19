module Errors
  class Invalid < BaseError
    attr_reader :details

    def initialize(record)
      @details = record.errors.to_hash(true)
      super(record.errors.full_messages.to_sentence)
    end

    def status
      :unprocessable_content # 422
    end
  end
end
