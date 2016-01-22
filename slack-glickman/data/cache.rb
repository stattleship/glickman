module SlackGlickman
  module Data
    class Cache
      def playermoji
        @playermoji ||= JSON.parse(json_for_filename('playermoji'))['playermoji'].freeze
      end

      def teamoji
        @teamoji ||= JSON.parse(json_for_filename('teamoji'))['teamoji'].freeze
      end

      private

      def json_for_filename(filename)
        path = File.join(File.dirname(__FILE__), "#{filename}.json")
        File.read(path)
      end
    end
  end
end
