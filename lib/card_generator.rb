require "./lib/card.rb"

class CardGenerator
  attr_reader :filename

  def initialize(filename)
    @filename = filename
  end

  def cards
    File.readlines(@filename, chomp: true).map do |line|
      question, answer, category = line.split(',')
      Card.new(question, answer, category)
    end
  end
end