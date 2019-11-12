class GamesController < ApplicationController
  require 'open-uri'
  require 'json'

  def new
    letters = Array('A'..'Z')
    @letters = Array.new(10) { letters.sample }
  end

  def score
    if (in_grid? && english?) == true
      "Congratulations #{params[:word]} is a valid word in english"
    elsif in_grid? == false
      "Sorry but #{params[:word]} does not seem be a valid english word..."
    else "Sorry but #{params[:word]} can't be built ouf of #{@letters}"
    end
  end

  def english?
    url = "https://wagon-dictionary.herokuapp.com/#{params[:word]}"
    request = open(url).read
    response = JSON.parse(request)
    @validation = response['found']
  end

  def in_grid?
    split_answer = params[:word].upcase.split('')
    letters = params[:letters].split(' ')
    split_answer.each do |letter|
      if letters.include?(letter)
        letters.delete_at(letters.index(letter))
      end
    end
  end
end
