module SlackGlickman
  module Commands
    class BaseCommand < SlackRubyBot::Commands::Base
      def self.send_message(client, data, text, options = {})
        snackable = Stattleship::Snackable.new(data: data, text: text)

        if SlackGlickman::App.instance.analytics
          SlackGlickman::App.instance.analytics.identify({ user_id: data.user,
                               traits: {}
                             })
          SlackGlickman::App.instance.analytics.track({ user_id: data.user,
                            event: options['expression'] || default_command_name,
                            properties: snackable.payload
                          })
        end

        if ENV['OGLETHORPE_SLACK_API_TOKEN']
          response = snackable.post
          link = (response['url'] || '').gsub('url', '')
          message = [text, link].join(' ').strip
        else
          message = text
        end

        super(client, data.channel, message, options.merge(unfurl_links: false, unfurl_media: false))
      end

      def self.send_gif(client, data, options = {})
        if SlackGlickman::App.instance.analytics
          SlackGlickman::App.instance.analytics.identify({ user_id: data.user,
                               traits: {}
                             })
          SlackGlickman::App.instance.analytics.track({ user_id: data.user,
                            event: options['expression'] || default_command_name,
                            properties: { channel: data.channel,
                                          gif: options }
                          })
        end

        super(client, data.channel, options)
      end
    end
  end
end
