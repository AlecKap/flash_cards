require "./lib/turn.rb"
require "./lib/card.rb"
require "./lib/deck.rb"
require "./lib/round.rb"

RSpec.describe Round do
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
    @round = Round.new(@deck)
  end

  describe "It exists and has attributes" do
    it "exists" do
      expect(@round).to be_a(Round)
    end

    it "Has a deck" do
      expect(@round.deck).to be_a(Deck)
    end
    
    it "has turns" do
      expect(@round.turns).to be_an(Array)
      expect(@round.turns).to eq([])
    end

    it "has a current_card" do
      expect(@round.current_card).to eq(@card_1)
    end

    it "Has number_correct" do
      expect(@round.number_correct).to eq(0)
    end

    it "has correct_cat_answers" do
      expect(@round.correct_cat_answers).to be_an(Array)
    end
  end

  describe "#take_turn" do
    before :each do
      @new_turn = @round.take_turn("Juneau")
    end

    it "creates a new Turn instance" do
      expect(@new_turn).to be_a(Turn)
      expect(@new_turn.correct?).to be(true)
    end

    it "returns the newly created turn" do
      expect(@new_turn).to be_a(Turn)
    end

    it "reassigns current_card to the next card" do
      expect(@round.turns.count).to eq(1)
      expect(@round.current_card).to eq(@card_2)
      
      @round.take_turn("Juneau")
      
      expect(@round.turns.count).to eq(2)
      expect(@round.current_card).to eq(@card_3)
    end
    
    it "adds the new turn to the rounds turns" do
      expect(@round.turns).to eq([@new_turn])
    end
    
    it "adds 1 to _number_correct if the guess is correct" do
      expect(@round.turns.count).to eq(1)
      expect(@round.number_correct).to eq(1)
      
      @round.take_turn("wrong answer")
      
      expect(@round.turns.count).to eq(2)
      expect(@round.number_correct).to eq(1)
      
      @round.take_turn("North north west")
      
      expect(@round.turns.count).to eq(3)
      expect(@round.number_correct).to eq(2)
    end
  end

  describe "#number_correct_by_category" do
    it "returns number of correct answers by a given category" do
      expect(@round.number_correct_by_category(:Geography)).to eq(0)
      
      @round.take_turn("Juneau")

      expect(@round.number_correct_by_category(:Geography)).to eq(1)
      expect(@round.number_correct_by_category(:STEM)).to eq(0)
    end
  end

  describe "#percent_correct" do
    it "returns the percntage of correct answers for a round" do
      @round.take_turn("Juneau")
      @round.take_turn("Mars")
      @round.take_turn("wrong answer")

      expect(@round.percent_correct).to eq(66.67)
    end
  end

  describe "#percent_correct_by_category" do
    it "returns the percntage of correct answers for a given category for a round" do
      @round.take_turn("Juneau")
      @round.take_turn("Mars")
      @round.take_turn("wrong answer")

      expect(@round.percent_correct_by_category(:STEM)).to eq(50)
      expect(@round.percent_correct_by_category(:Geography)).to eq(100)
    end
  end
end