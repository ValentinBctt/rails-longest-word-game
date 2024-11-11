require 'json'
require 'open-uri'

class GamesController < ApplicationController
  def new
    alphabet = ('a'..'z').to_a
    @letters = 10.times.map { alphabet.sample }
  end

  def score
    @user_input = params[:answer]
    @letters = params[:letters]

    url = "https://dictionary.lewagon.com/#{@user_input}"
    user_serialized = URI.parse(url).read
    response = JSON.parse(user_serialized)


    if response['word'] && @user_input.chars.any? { |letter| @letters.include?(letter) }
      @score = "Yout score is #{@user_input.length}"
    else
      @score = "This word doesn't exist in the dictionary."
    end

    if @user_input.chars.any? { |letter| !@letters.include?(letter) }
      @score = "Can't build with the letters"
      return
    end


  end
end
