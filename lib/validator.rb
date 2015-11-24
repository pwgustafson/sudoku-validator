require 'sudoku.rb'

class Validator
  def initialize(puzzle_string)
    @puzzle_string = puzzle_string
    @sudoku = Sudoku.new(@puzzle_string)
  end

  def self.validate(puzzle_string)
    new(puzzle_string).validate
  end

  def validate
    @sudoku.validate
  end

end
