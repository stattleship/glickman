module SlackGlickman
  module Commands
    class Teamoji < SlackGlickman::Commands::BaseCommand

      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)

        command "teamoji :#{statmoji}:" do |client, data, _match|
          teamojis = []

          SlackGlickman::App.instance.teamoji.each do |sportmoji|
            next unless sport == sportmoji['sport']
            statmoji = sportmoji['emoji']

            sportmoji['teams'].each do |team|
              teamoji = team['emoji']['slack']
              teamojis << "#{teamoji} #{team['location']} #{team['nickname']}"
            end
          end

          msg = teamojis.join("\n")

          send_message client, data, "All #{statmoji} teamojis!\n #{msg}"
        end
      end
    end
  end
end
