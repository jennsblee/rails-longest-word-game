require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    grid_array = []
    10.times do
      grid_array << ('A'..'Z').to_a.sample
    end
    @letters = grid_array
  end

  def score
    hash = JSON.parse(open("https://wagon-dictionary.herokuapp.com/#{params[:word]}").read)
    input_letters = params[:word].upcase.split('')
    condition = input_letters.all? { |letter| params[:letters].split(' ').count(letter) >= input_letters.count(letter) }
    if !condition
      @result = "Sorry but #{params[:word].upcase} can't be built out of #{@letters.join(', ')}"
    elsif !hash['found']
      @result = "Sorry but #{params[:word].upcase} does not seem to be a valid English word..."
    else
      @result = "Congratulations! #{params[:word].upcase} is a valid English word!"
    end
  end
end
