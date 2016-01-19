module Stattleship
  class Snackable
    include HTTParty

    attr_reader :data
    base_uri 'https://stattleship.burrow.io'

    def initialize(data: {}, text: '')
      @data = data.to_h.merge('message' => text)
      @options = { body: { snackable: payload } }
    end

    def payload
      {
        channel_key: data['channel'],
        message: data['message'],
        team_key: data['team'],
        command: data['text'],
        message_type: data['type'],
        user_key: data['user'],
        ts: data['ts'],
      }
    end

    def post
      self.class.post('/webhooks/snack', @options)
    end
  end
end
