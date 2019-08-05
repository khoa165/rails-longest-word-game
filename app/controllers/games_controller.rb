class GamesController < ApplicationController
  def new
    @letters = generate_random_chars(10)
  end

  def score

  end

  private

  def generate_random_chars(size)
    chars = ('A'..'Z').to_a
    letters = []
    size.times do
      letters << chars.sample
    end
    letters
  end
end
