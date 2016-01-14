module SlackGlickman
  module Commands
    class Venues < SlackGlickman::Commands::BaseCommand
      command ":stadium:" do |client, data, _match|
        send_message client, data, ":stadium: Attendance figures coming soon."
      end
    end
  end
end
