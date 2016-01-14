module SlackGlickman
  module Commands
    class Help < SlackGlickman::Commands::BaseCommand
      INFO_MESSAGE = "I'm Glickman, your statmoji(tm) sports slackbot powered by the Stattleship API. Read more at https://github.com/stattleship/glickman"

      command "help" do |client, data, _match|
        send_message client, data.channel, INFO_MESSAGE
      end

      command "about" do |client, data, _match|
        send_message client, data.channel, INFO_MESSAGE
      end

      command "me" do |client, data, _match|
        send_message client, data, "Hi <@#{data.user}>"
      end
    end
  end
end
