require 'matrix.rb'
require './lib/group.rb'

class Sudoku
  attr_reader :matrix, :rows, :cols, :boxes
  ROW_SPACER = "------+------+------"

  def initialize(puzzle_string=nil)
    @puzzle_string = puzzle_string #|| File.read("spec/fixtures/valid_incomplete.sudoku")
    @rows, @cols, @boxes = [], [], []
    parse_puzzle
  end

  def parse_puzzle
    rows = @puzzle_string.split("\n")
    rows = rows.delete_if { |row| row == ROW_SPACER}

    @rows = rows.inject([]) do |result, element|
      values = element.gsub("|", "").split(" ").map(&:to_i)
      row = values.map {|v| v == 0 ? nil : v}
      result << Group.new(row)
    end

    @matrix = Matrix.rows(array_rows)

    @cols = array_cols.inject([]) do |result, col|
      result << Group.new(col)
    end

    parse_boxes
  end

  def parse_boxes
    boxes = []
    array_rows.each_slice(3) do |row_set|
      boxes_tmp = [[],[],[]]
      row_set.each do |row|
        row.each_slice(3).with_index do |s,i|
          boxes_tmp[i] = boxes_tmp[i] + s
        end
      end
      boxes += boxes_tmp
    end
    @boxes = boxes.inject([]) do |result, box|
      result << Group.new(box)
    end
  end
  
  def array_rows
    @rows.inject([]) {|result, element| result << element.values }
  end

  def array_cols
    matrix.transpose.to_a
  end

  def complete?
    rows_complete? && 
    cols_complete? && 
    boxes_complete?
  end

  def valid?
    rows_valid? && 
    cols_valid? && 
    boxes_valid?
  end

  def rows_complete?
    @rows.all? {|row| row.complete?}
  end

  def rows_valid?
    @rows.all? {|row| row.valid? }
  end

  def cols_complete?
    @cols.all? {|col| col.complete?}
  end

  def cols_valid?
    @cols.all? {|col| col.valid?}
  end

  def boxes_complete?
    @boxes.all? {|box| box.complete?}
  end

  def boxes_valid?
    @boxes.all? {|box| box.valid?}
  end
end
