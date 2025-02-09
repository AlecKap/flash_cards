class Deck
  attr_reader :cards

  def initialize(cards)
    @cards = cards
  end

  def cards_in_category(cat)
    @cards.find_all { |card| card.category == cat }
  end
end