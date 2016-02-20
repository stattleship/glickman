module SlackGlickman
  class App < SlackRubyBot::App
    attr_reader :analytics, :cache, :map

    def initialize(options = {})
      super(options)

      @analytics ||= Segment::Analytics.new(write_key: ENV['SEGMENT_API_KEY']) if ENV['SEGMENT_API_KEY']
      @cache ||= Data::Cache.new
      @map ||= if ENV['SEGMENT_API_KEY']
                 GoogleStaticMap.new(api_key: ENV['GOOGLE_MAPS_API_KEY'])
                else
                  GoogleStaticMap.new
                end
    end

    def help
      cache.help
    end

    def playermoji
      cache.playermoji
    end

    def teamoji
      cache.teamoji
    end
  end
end
