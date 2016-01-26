# glickman

Glickman is your statmoji(tm) sports slackbot powered by the Stattleship API. [https://www.stattleship.com](https://www.stattleship.com).

Its namesake is [Marty Glickman](https://en.wikipedia.org/wiki/Marty_Glickman), a pioneering American radio announcer and sportscaster.

This bot is make possible by [Slack-Ruby-Bot](https://github.com/dblock/slack-ruby-bot), a generic Slack bot framework written in Ruby on top of [slack-ruby-client](https://github.com/dblock/slack-ruby-client).

It also relies on the [stattleship-ruby](https://github.com/stattleship/stattleship-ruby) gem to fetch sports stats and info as well as our list of [teamojis](https://github.com/stattleship/teamoji) in many of its commands.

# Try It Out!

Join our public [Fanboat](http://fanboat.stattleship.com/) Slack channels and try out "cosell", its Glickman bot integration.

You can try out any of the commands below, just use "cosell:" instead of "glickman:" to talk to the bot.

# Installation

See: https://github.com/dblock/slack-ruby-bot/blob/master/TUTORIAL.md

After bundling and setting up your `.env` file the the API keys, you should be able to run `foreman start` to get the bot up and running.

Note: current uses a pre-release version the the [stattleship-ruby](https://github.com/stattleship/stattleship-ruby) gem.

## Heroku Deploy

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Stattleship API Key

You'll need a `.env` with API keys

```
SLACK_API_TOKEN=
STATTLESHIP_ACCESS_TOKEN=
```

You can get a Stattleship API key at [http://www.stattleship.com](http://www.stattleship.com).

# Commands

Glickman knows a good deal about sports.

![What's hot in basketball](/screenshots/fire_basketball.gif?raw=true "What's hot in basketball")

## Colors

List team colors.

![Team Colors](/screenshots/colors.png?raw=true "Team Colors")

:lower_left_paintbrush: :basketball:

:lower_left_paintbrush: :football:

:lower_left_paintbrush: :ice_hockey_stick_and_puck:

Or for a team,

:lower_left_paintbrush: :cow: :basketball:

:lower_left_paintbrush: :cow: :football:

:lower_left_paintbrush: :bear: :ice_hockey_stick_and_puck:

## Player Game Log

### Last

![Basketball Game Log](/screenshots/basketball_player_game_log.gif?raw=true "Basketball Game Log")

:basketball: first_name last_name

:football: first_name last_name

![Hockey Game Log](/screenshots/hockey_player_game_log.gif?raw=true "Hockey Game Log")

:ice_hockey_stick_and_puck: first_name last_name

For example:

:basketball: Lebron James

:football: tom brady

:ice_hockey_stick_and_puck: tyler seguin

### Random

![Basketball Game Log](/screenshots/basketball_player_game_log.gif?raw=true "Basketball Game Log")

:basketball: :game_die: first_name last_name

:football: :game_die: first_name last_name

![Hockey Game Log](/screenshots/hockey_player_game_log.gif?raw=true "Hockey Game Log")

:ice_hockey_stick_and_puck: :game_die: first_name last_name

For example:

:basketball: :game_die: Lebron James

:football: :game_die: tom brady

:ice_hockey_stick_and_puck: :game_die: tyler seguin

## Feats

![Feats in action](/screenshots/feats.gif?raw=true "Feats in action")

:tophat: Hat tricks in hockey

:fire: :basketball:

:fire: :football:

:fire: :ice_hockey_stick_and_puck:

:rotating_light: Recent goals scored (5 random sampling)

## Stat Leaders

Goalie shutout leaders

:doughnut:

Rusing yard leaders

:runner:

## Top Stats

Top field goals made basketball performances

:rain_cloud:

Top three pointers basketball performances

:thunder_cloud_and_rain:

## Results

:no_mouth: :four_leaf_clover: :basketball:

:no_mouth: :bear: :ice_hockey_stick_and_puck:

## Schedules

![Schedules](/screenshots/schedules.gif?raw=true "Schedules")

:calendar: :basketball:

:calendar: :football:

:calendar: :ice_hockey_stick_and_puck:

### Schedule For Team

:calendar: :four_leaf_clover: basketball:

:calendar: :cow: :football:

:calendar: :bear: :ice_hockey_stick_and_puck:

## Scores

In-progress and recently ended game scores per sport

:mega: :basketball:

:mega: :football:

:mega: :ice_hockey_stick_and_puck:

## Scoring Plays

Recent random sampling of scoring plays for the NFL :football: and NHL :snowflake:. NBA :basketball: does not have scoring play data.

:tada: teamoji sport

For example:

:tada: :maple_leaf: :ice_hockey_stick_and_puck:

![NHL Scoring Plays](/screenshots/tada_nhl_maple_leaf_goals_scored.png?raw=true "NHL Scoring Plays")

:tada: :cat: :football:

![NFL Scoring Plays](/screenshots/tada_nfl_carolina_panthers_scoring_plays.png?raw=true "NFL Scoring Plays")

## Injuries

Random injury report per sport

![Injury report](/screenshots/injuries.gif?raw=true "Injury report")

:face_with_head_bandage: :basketball:

:face_with_head_bandage: :football:

:face_with_head_bandage: :ice_hockey_stick_and_puck:

## Penalties

Recent random sampling of penalties for NHL :snowflake:. NBA :basketball: and the NFL :football: and do not have penalty data.

:package: :statue_of_liberty: :ice_hockey_stick_and_puck:

![NHL Penalties](/screenshots/package_nhl_ny_rangers_penalties.png?raw=true "NHL Penalties")

## Players

Use teamoji(tm) to get a list of player deets.

![Players](/screenshots/players.gif?raw=true "Players")

Celtics

:shirt: :four_leaf_clover: :basketball:

Chicago Bears

:shirt: :bear: :football:

Memphis Grizzlies

:shirt: :bear: :basketball:

Boston Bruins

:shirt: :bear: :ice_hockey_stick_and_puck:

## Basketball Doubles

![Doubles](/screenshots/doubles.gif?raw=true "Doubles")

:slot_machine: Triple Doubles

:hamburger: Double double

## Frivolities

:eggplant:

:pizza:

Easter eggs!

## Playermojis

Each return a random player game log

:crown: Lebron James

:curry: Stephen Curry

:rose: Derrick Rose

## Teamojis

Use [teamojis](https://github.com/stattleship/teamoji) with the player, schedule commands.

These commands return the [teamojis](https://github.com/stattleship/teamoji) for their league.

teamoji :basketball:

teamoji :football:

teamoji :ice_hockey_stick_and_puck:

## GIFs

Random giphy for Boston Celtics ...

:movie_camera: :four_leaf_clover: :basketball:

... and Bruins.

:movie_camera: :bear: :ice_hockey_stick_and_puck:
