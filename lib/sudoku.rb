require 'matrix.rb'
require './lib/row.rb'

class Sudoku
  attr_reader :matrix, :rows, :cols

  def initialize(puzzle_string=nil)
    @puzzle_string = puzzle_string  || File.read("spec/fixtures/valid_incomplete.sudoku")
    @rows = []
    @cols = []
    parse_puzzle
    @matrix = Matrix.rows(array_rows)
    puts array_rows
  end

  def parse_puzzle
    rows = @puzzle_string.split("\n")
    rows = rows.delete_if { |row| row == row_spacer}

    @rows = rows.inject([]) do |result, element|
      values = element.gsub("|", "").split(" ").map(&:to_i)
      row = values.map {|v| v == 0 ? 0 : v}
      result << Row.new(row)
    end
  end
  
  def validate
    if !valid?
      invalid_message
    elsif valid? && incomplete?
      valid_incomplete_message
    else
      valid_message
    end
   
  end

  def array_rows
    @rows.inject([]) {|result, element| result << element.values }
  end

  def valid?
    rows_valid? && cols_valid?
  end

  def row_spacer
    "------+------+------"
  end

  def cols
    matrix.transpose.to_a
  end

  def cols_valid?
    cols.each do |col|
      col = Row.new(col)
      return false unless col.valid?
    end
    return true
  end

  def rows_valid?
    rows = matrix.to_a
    rows.each do |row|
      row = Row.new(row)
      return false unless row.valid?
    end
    return true
  end

  def incomplete?
    array_rows.flatten.include?(0)
  end

  def valid_message
    "This sudoku is valid."
  end

  def valid_incomplete_message
    "This sudoku is valid, but incomplete."
  end

  def invalid_message
    "This sudoku is invalid."
  end
end
