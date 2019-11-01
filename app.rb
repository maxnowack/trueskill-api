require 'sinatra'
require 'json'
require 'bundler/setup'
require 'saulabs/trueskill'

include Saulabs::TrueSkill

set :port, ENV['PORT'] || 5000
set :bind, '0.0.0.0'
set :dump_errors, true
set :raise_errors, false

post '/' do
  data = JSON.parse(request.body.read)

  players1 = data['team1'].map {|player| { 'userId' => player['userId'], 'rating' => Rating.new(player['mean'], player['deviation'], player['activity'])} }
  players2 = data['team2'].map {|player| { 'userId' => player['userId'], 'rating' => Rating.new(player['mean'], player['deviation'], player['activity'])} }

  team1 = players1.map { |player| player['rating'] }
  team2 = players2.map { |player| player['rating'] }


  # team 1 wins by 10 points against team 2
  graph = ScoreBasedBayesianRating.new(team1 => 10.0, team2 => -10.0)

  # update the Ratings
  graph.update_skills

  newData = { 'team1' => [], 'team2' => [] }
  team1.each_index do |i|
    newData['team1'][i] = {
      'userId' => players1[i]['userId'],
      'mean' => team1[i].mean,
      'deviation' => team1[i].deviation,
    }
  end

  team2.each_index do |i|
    newData['team2'][i] = {
      'userId' => players2[i]['userId'],
      'mean' => team2[i].mean,
      'deviation' => team2[i].deviation,
    }
  end

  status 200
  response.headers['Content-Type'] = 'application/json'
  body newData.to_json
end
