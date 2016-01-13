module SlackGlickman
  class App < SlackRubyBot::App
    attr_reader :cache

    def initialize(options = {})
      super(options)

      @cache ||= Data::Cache.new
    end

    def teamoji
      cache.teamoji
    end
  end
end
