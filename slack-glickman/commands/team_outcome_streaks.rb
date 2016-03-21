module SlackGlickman
  module Commands
    class TeamOutcomeStreaks < SlackGlickman::Commands::BaseCommand
      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)
        command ":comet: :#{statmoji}:" do |client, data, _match|
          streak_sentences = []

          current_team_outcome_streaks(sport: sport, team_id: nil).each do |streak|
            if streak.streak_length > 1
              streak_sentences << streak.to_sentence
            end
          end

          options = {}

          if streak_sentences.length == 0
            client.say(options.merge(channel: data.channel, text: "No #{statmoji} streaks"))
          else
            client.say(options.merge(channel: data.channel, text: streak_sentences.join("\n")))
          end
        end
      end

      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)
        command ":comet: :joy: :#{statmoji}:" do |client, data, _match|
          streak_sentences = []

          current_team_winning_streaks(sport: sport, team_id: nil).each do |streak|
            if streak.streak_length > 1
              streak_sentences << streak.to_sentence
            end
          end

          options = {}

          if streak_sentences.length == 0
            client.say(options.merge(channel: data.channel, text: "No #{statmoji} :joy: streaks"))
          else
            client.say(options.merge(channel: data.channel, text: streak_sentences.join("\n")))
          end
        end
      end

      SlackGlickman::App::SPORTS.each do |sport|
        statmoji = SlackGlickman::App.instance.statmoji_for_sport(sport: sport)
        command ":comet: :cry: :#{statmoji}:" do |client, data, _match|
          streak_sentences = []

          current_team_losing_streaks(sport: sport, team_id: nil).each do |streak|
            if streak.streak_length > 1
              streak_sentences << streak.to_sentence
            end
          end

          options = {}

          if streak_sentences.length == 0
            client.say(options.merge(channel: data.channel, text: "No #{statmoji} :cry: streaks"))
          else
            client.say(options.merge(channel: data.channel, text: streak_sentences.join("\n")))
          end
        end
      end

      SlackGlickman::App.instance.teamoji.each do |sportmoji|
        sportmoji['teams'].each do |team|
          sport = sportmoji['sport']
          statmoji = sportmoji['emoji']
          teamoji = team['emoji']['default']

          command ":comet: #{teamoji} #{statmoji}" do |client, data, _match|
            streak_sentences = []

            current_team_outcome_streaks(sport: sport, team_id: team['slug']).each do |streak|
              streak_sentences << streak.to_sentence
            end

            options = {}

            if streak_sentences.length == 0
              client.say(options.merge(channel: data.channel, text: "No current #{teamoji} #{statmoji} streaks"))
            else
              client.say(options.merge(channel: data.channel, text: streak_sentences.join("\n")))
            end
          end
        end
      end

      def self.current_team_winning_streaks(sport: 'basketball', team_id: nil, outcome: nil)
        self.current_team_outcome_streaks(sport: sport, team_id: nil, outcome: 'win')
      end

      def self.current_team_losing_streaks(sport: 'basketball', team_id: nil, outcome: nil)
        self.current_team_outcome_streaks(sport: sport, team_id: nil, outcome: 'loss')
      end

      def self.current_team_outcome_streaks(sport: 'basketball', team_id: nil, outcome: nil)
        self.team_outcome_streaks(sport: sport, team_id: team_id, current: true, outcome: outcome)
      end

      def self.team_outcome_streaks(sport: 'basketball', team_id: nil, current: nil, outcome: nil)
        query_params = const_get("Stattleship::Params::#{sport.capitalize}TeamOutcomeStreaksParams").new
        query_params.current = current
        query_params.outcome = outcome
        query_params.team_id = team_id

        const_get("Stattleship::#{sport.capitalize}TeamOutcomeStreaks").
                  fetch(params: query_params)
      end
    end
  end
end
