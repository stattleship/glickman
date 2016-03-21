module SlackGlickman
  module Commands
    class Frivolities < SlackGlickman::Commands::BaseCommand
      command ":batpig:" do |client, data, _match|
        send_gif(client, data, 'french bulldog')
      end

      command ":eggplant:" do |client, data, _match|
        send_gif(client, data, 'brett favre')
      end

      command ":eyeglasses:" do |client, data, _match|
        send_gif(client, data, 'major league wild thing')
      end

      command ":unicorn_face:" do |client, data, _match|
        send_message client, data, ":rainbow: :rainbow: :rainbow: :rainbow: :rainbow:"
      end

      command ":pizza:" do |client, data, _match|
        query_params = Stattleship::Params::FootballGameLogsParams.new

        query_params.player_id = 'nfl-peyton-manning'

        game_logs = Stattleship::FootballGameLogs.fetch(params: query_params)

        msg = game_logs.sample.to_sentence

        send_message client, data, ":pizza: #{msg}"
      end

      command ":table_tennis_paddle_and_ball:" do |client, data, _match|
        send_gif(client, data, 'pong')
      end
    end
  end
end
