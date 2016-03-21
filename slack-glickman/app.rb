module SlackGlickman
  class App < SlackRubyBot::App
    attr_reader :analytics, :cache

    SPORTS = ['basketball', 'football', 'hockey', 'baseball'].freeze

    def initialize(options = {})
      super(options)

      @analytics ||= Segment::Analytics.new(write_key: ENV['SEGMENT_API_KEY']) if ENV['SEGMENT_API_KEY']
      @cache ||= Data::Cache.new
    end

    def help
      cache.help
    end

    def playermoji
      cache.playermoji
    end

    def statmoji_for_sport(sport:)
      if sport == 'hockey'
       'ice_hockey_stick_and_puck'
      else
        sport
      end
    end

    def teamoji
      cache.teamoji
    end
  end
end
