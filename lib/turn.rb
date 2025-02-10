class Turn
  attr_reader :guess, :card

  def initialize(guess, card)
    @guess = guess
    @card = card
  end

  def correct?
    @guess.downcase == @card.answer.downcase
  end

  def feedback
    if correct?
      "Correct!"
    else
      "Sorry, that is incorrect. The correct answer is #{@card.answer}"
    end
  end
end