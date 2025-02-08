require "./lib/turn.rb"
require "./lib/card.rb"

RSpec.describe Turn do
  before :each do
    @card = Card.new("What is the capital of Alaska?", "Juneau", :Geography)
    @turn = Turn.new("Juneau", @card)
  end
  
  describe "turn exists and has attributes" do

    it "exists" do
      expect(@turn).to be_instance_of(Turn)
    end

    it "has a guess" do
      expect(@turn.guess).to eq("Juneau")
    end

    it "has a card" do
      expect(@turn.card).to be_a(Card)
      expect(@turn.card).to eq(@card)
    end
  end

  describe "#correct?" do
    it "determins if the guess is correct" do
      expect(@turn.correct?).to be(true)
    end
    
    it "determins if the guess is incorrect" do
      turn = Turn.new("Springfield", @card)

      expect(turn.correct?).to be(false)
    end
  end

  describe "#feedback" do
    it "returns positive feedback if outcome of #correct? is true" do
      expect(@turn.feedback).to eq("Correct!")
    end
    
    it "returns negative feedback if outcome of #correct? is false" do
      turn = Turn.new("Springfield", @card)
      
      expect(turn.feedback).to eq("Sorry, that is incorrect.")
    end
  end
end