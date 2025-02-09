require "./lib/turn.rb"
require "./lib/card.rb"
require "./lib/deck.rb"

RSpec.describe Deck do
  before :each do
    @card_1 = Card.new("What is the capital of Alaska?", 
                       "Juneau",
                       :Geography)
    @card_2 = Card.new("The Viking spacecraft sent back to Earth photographs and reports about the surface of which planet?",
                       "Mars",
                       :STEM)
    @card_3 = Card.new("Describe in words the exact direction that is 697.5° clockwise from due north?",
                       "North north west",
                       :STEM)
    @cards = [@card_1, @card_2, @card_3]
    @deck = Deck.new(@cards)
  end

  describe "It exists and has attributes" do
    it "exists" do
      expect(@deck).to be_a(Deck)
    end

    it "has cards" do
      expect(@deck.cards).to be_an(Array)
      expect(@deck.cards.count).to eq(3)
      expect(@deck.cards).to eq([@card_1, @card_2, @card_3])
    end
  end

  describe "#cards_in_category" do
    it "returns all cards in a given category" do
      expect(@deck.cards_in_category(:STEM)).to eq([@card_2, @card_3])
      expect(@deck.cards_in_category(:Geography)).to eq([@card_1])
      expect(@deck.cards_in_category(:pop_culture)).to eq([])
    end
  end
end