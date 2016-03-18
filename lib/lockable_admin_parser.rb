class AdminInterface
  class LockableAdminParser

    class InvalidPermalinks < StandardError; end
    class TooRisky < StandardError; end

    attr_reader :params

    def initialize(params)
      @params = params
    end

    def permalinks
      #TODO pluralize this key
      params.fetch('permalink')
    end

    def emails
      params.fetch('emails')
    end

    def command
      params.fetch('command')
    end

    def authorized_by
      params.fetch('authorized_by')
    end

    def validate!
      raise(
        InvalidPermalinks, "Invalid permalinks: #{invalid_permalinks.join(', ')}"
      ) if invalid_permalinks.any?

      raise(
        TooRisky, "too risky"
      ) if command == 'unlock' && permalinks.none?
    end

    private

    def invalid_permalinks
      @invalid_permalinks ||=
        permalinks - ::Company.where(permalink: permalinks).pluck(:permalink)
    end

  end

end
