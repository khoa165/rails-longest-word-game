require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = 10.times.map { ('A'..'Z').to_a.sample }
  end

  def score
    @grid = params[:grid].split(" ")
    @info = run_game(params[:word], @grid)
  end

  private

  def follow_rule?(attempt, grid)
    attempt.split("").each do |char|
      if grid.include?(char)
        position = grid.index(char)
        grid.delete_at(position)
      else
        return false
      end
    end
    return true
  end

  def run_game(attempt, grid)
    message = "You are not following the rule, one or more of the characters you used are not in the grid!"
    return { score: 0, message: message } unless follow_rule?(attempt.upcase, grid)


    url = "https://wagon-dictionary.herokuapp.com/#{attempt}"
    json_file = open(url).read
    result = JSON.parse(json_file) # result is a hash

    score = result["found"] ? 100 * attempt.length : 0
    message = result["found"] ? "Well done!!!" : "Your answer is not an english word, you don't receive any point."
    return { score: score, message: message }
  end
end
