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

        if ENV['OGLETHORPE_SLACK_API_TOKEN'].present?
          if text.nil? || text.length == 0
            message = text
          else
            response = snackable.post
            link = (response['url'] || '').gsub('url', '')
            message = [text, link].join(' ').strip
          end
        else
          message = text
        end

        client.say(options.merge(unfurl_links: false,
                                 unfurl_media: false,
                                 channel: data.channel, text: message))
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

      def self.send_error(client, data, text, options = {})
        message = ":robot_face: uh oh\n#{text}"
        client.say(options.merge(channel: data.channel, text: message))
      end
    end
  end
end
