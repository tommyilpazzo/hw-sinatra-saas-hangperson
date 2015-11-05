class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def guess(letter)
    raise ArgumentError if letter.nil? or letter.empty? or !letter.match(/^[a-zA-Z]+$/)
    return false if (@guesses+@wrong_guesses).include? letter.downcase
    if @word.downcase.include? letter.downcase then @guesses << letter.downcase 
      else @wrong_guesses << letter.downcase end
    return true
  end
  
  def word_with_guesses
    @word.chars.map{|l| if @guesses.include? l.downcase then l else '-' end}.join
  end
  
  def check_win_or_lose
    return :lose unless @wrong_guesses.length < 7
    return :win if @word.downcase.chars.sort == @guesses.chars.sort
    return :play
  end
  
end