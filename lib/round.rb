class Round
  attr_reader :deck,
              :turns,
              :current_card,
              :number_correct,
              :correct_cat_answers

  def initialize(deck)
    @deck = deck
    @turns = []
    @current_card = @deck.cards.first
    @number_correct = 0
    @correct_cat_answers = []
  end

  def take_turn(guess)
    turn = Turn.new(guess, @current_card)
    @turns << turn
    if guess.downcase == @current_card.answer.downcase
      @number_correct += 1
      @correct_cat_answers << @current_card.category
    end
    @current_card = @deck.cards.rotate!.first
    turn
  end

  def number_correct_by_category(category)
    @correct_cat_answers.find_all { |cat| cat == category }.count
  end

  def percent_correct
    (@number_correct.fdiv(@turns.count) * 100).round(2)
  end

  def percent_correct_by_category(category)
    num_of_cards_by_cat = @deck.cards.find_all { |card| card.category == category }.count
    (number_correct_by_category(category).fdiv(num_of_cards_by_cat) * 100).round(2)
  end

  def last_guess_feedback
    @turns.last.feedback
  end

  def num_of_cards
    @deck.cards.count
  end

  def stats_feedback
    if percent_correct >= 90
      "WOW 100%!! That is pretty darn impressive!"
    elsif percent_correct < 1
      "wow... that's just embarrasing. Go read a book!"
    elsif percent_correct >= 80
      "Not bad! Not bad at all!"
    elsif percent_correct >= 70
      "Hey, that isn't terrible. It's ok to be average."
    else 
      "Come on... I know you can do better than that."
    end
  end

  def category_stats
    cats = @deck.cards.map { |card| card.category }.uniq
    cats.each do |cat|
      puts "#{cat.to_s.gsub(/_/, " ").capitalize} - #{percent_correct_by_category(cat)}%"
    end
  end
end