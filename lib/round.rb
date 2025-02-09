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
    if guess == @current_card.answer
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
end