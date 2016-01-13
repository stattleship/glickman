module SlackGlickman
  module Commands
    class Teamoji < SlackRubyBot::Commands::Base

      ['basketball', 'football', 'hockey'].each do |sport|
        statmoji = if sport == 'hockey'
                     'ice_hockey_stick_and_puck'
                    else
                      sport
                    end

        command "teamoji :#{statmoji}:" do |client, data, _match|
          teamojis = []

          SlackGlickman::App.instance.teamoji.each do |sportmoji|
            next unless sport == sportmoji['sport']
            statmoji = sportmoji['emoji']

            sportmoji['teams'].each do |team|
              teamoji = team['emoji']['default']
              teamojis << "#{teamoji} #{team['location']} #{team['nickname']}"
            end
          end

          msg = teamojis.join("\n")

          send_message client, data.channel, "All #{statmoji} teamojis!\n #{msg}"
        end
      end
    end
  end
end
