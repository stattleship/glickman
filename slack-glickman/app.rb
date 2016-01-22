module SlackGlickman
  class App < SlackRubyBot::App
    attr_reader :analytics, :cache

    def initialize(options = {})
      super(options)

      @analytics ||= Segment::Analytics.new(write_key: ENV['SEGMENT_API_KEY']) if ENV['SEGMENT_API_KEY']
      @cache ||= Data::Cache.new
    end

    def playermoji
      cache.playermoji
    end

    def teamoji
      cache.teamoji
    end
  end
end
