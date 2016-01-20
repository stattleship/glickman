module Stattleship
  class Snackable
    include HTTParty

    attr_reader :data, :text
    base_uri ENV.fetch('OGLETHORPE_URI', 'https://oglethorpe.stattleship.com')

    def initialize(data: {}, text: '')
      @data = data.to_h
      @text = text
      @options = { body: { snackable: payload, signature: signature } }
    end

    def payload
      {
        channel_key: data['channel'],
        team_key: data['team'],
        command: data['text'],
        message_type: data['type'],
        user_key: data['user'],
        ts: data['ts'],
      }.merge('message' => text)
    end

    def auth_token
      ENV['OGLETHORPE_SLACK_API_TOKEN']
    end

    def headers
      { 'Authorization' => "Token token=#{auth_token}" }
    end

    def signature
      if ENV['OGLETHORPE_SLACK_API_TOKEN']
        Stattleship::Util::RequestValidator.new(auth_token: auth_token).
          signature(payload)
      end
    end

    def post
      self.class.post('/webhooks/snack', @options.merge(headers: headers))
    end
  end
end
