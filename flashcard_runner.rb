require "./lib/turn.rb"
require "./lib/card.rb"
require "./lib/deck.rb"
require "./lib/round.rb"
require "./lib/card_generator.rb"

def setup
  # @card_1 = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
  # @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?", "Mars", :STEM)
  # @card_4 = Card.new("How many Stanley Cups have the Chicago Blackhawks hockey team won?", "6", :Sports)
  # @card_5 = Card.new("Who invented Ruby?", "Yukihiro Matsumoto", :Code_questions)
  # @card_6 = Card.new("Who invented Rails?", "DHH", :Code_questions)
  # cards = [@card_1, @card_2, @card_4, @card_5, @card_6]
  cards = CardGenerator.new("cards.txt").cards
  deck = Deck.new(cards.sample(rand(1..(10))))
  @round = Round.new(deck)
end

def welcome
  puts "Welcome to the flashcard trivia game!"
  sleep(0.5)
  puts "Would you like to play? (y/n)"
  player_answer = gets.chomp.downcase
  until player_answer == "y" || player_answer == "n"
    puts "I'm sorry, that is not a valid response. Please type y or n."
    player_answer = gets.chomp.downcase
  end
  if player_answer == "y"
    sleep(0.5)
    puts "Awesome... let's get started!"
  else
    print "Oh "
    sleep(1)
    print "."
    sleep(1)
    print "."
    sleep(1)
    print "."
    sleep(1)
    print "."
    puts " Ok goodbye then"
    sleep(1)
    puts " :("
    sleep(1.5)
    exit
  end
end


def game_round
  setup
  sleep(1)
  puts "You will get #{@round.num_of_cards} questions."
  puts "----------------------------------------------------------"
  sleep(1)
  question_num = 1
  @round.num_of_cards.times do
    puts "Question #{question_num} of #{@round.num_of_cards}: #{@round.current_card.question}"
    player_guess = gets.chomp 
    @round.take_turn(player_guess)
    sleep(0.5)
    print "."
    sleep(0.5)
    print "."
    sleep(0.5)
    print "."
    sleep(0.5)
    puts " #{@round.last_guess_feedback}"
    sleep(0.5)
    question_num += 1
  end
  game_over_stats
  play_again?
end

def play_again?
  puts "Would you like to play again? (y/n)"
  play_again = gets.chomp.downcase
  
  until play_again == "y" || play_again == "n"
    puts "I'm sorry, that is not a valid response. Please type y or n."
    play_again = gets.chomp.downcase
  end

  if play_again == "y"
    sleep(0.5)
    puts "Awesome... let's play again!"
    sleep(1)
    game_round
  else
    print "Had enough have you?"
    sleep(1)
    print "."
    sleep(1)
    print "."
    sleep(1)
    print "."
    sleep(1)
    print "."
    puts " Ok goodbye then"
    sleep(1)
    puts " :("
    sleep(1.5)
    exit
  end
end

def game_over_stats
  puts "******* GAME OVER ******* "
  sleep(1)
  puts "Here are some stats from your game."
  sleep(0.5)
  print "."
  sleep(0.5)
  print "."
  sleep(0.5)
  print "."
  sleep(1)
  puts "You got #{@round.number_correct} correct out of the #{@round.num_of_cards} questions!"
  sleep(1.5)
  puts "That's a whopping #{@round.percent_correct}%!"
  sleep(1.5)
  puts "#{@round.stats_feedback}"
  sleep(1.5)
  puts "Here are some stats by category:"
  sleep(1.5)
  @round.category_stats
  sleep(3)
end

def start_game
  welcome
  game_round
end

start_game

