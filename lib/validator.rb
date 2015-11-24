require 'sudoku.rb'

class Validator
  VALID_MESSAGE = "This sudoku is valid."
  VALID_INCOMPLETE_MESSAGE = "This sudoku is valid, but incomplete."
  INVALID_MESSAGE = "This sudoku is invalid."
  
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
    @sudoku = Sudoku.new(@puzzle_string)
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    if !@sudoku.valid?
      INVALID_MESSAGE
    elsif @sudoku.valid? && !@sudoku.complete?
      VALID_INCOMPLETE_MESSAGE
    else
      VALID_MESSAGE
    end
  end

end
