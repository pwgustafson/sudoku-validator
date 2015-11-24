require './lib/group.rb'

class Sudoku
  attr_reader :rows, :cols, :boxes
  ROW_SPACER = "------+------+------"

  def initialize(puzzle_string=nil)
    @puzzle_string = puzzle_string
    @rows, @cols, @boxes = [], [], []
    parse_puzzle
  end

  def parse_puzzle
    parse_rows
    parse_cols
    parse_boxes
  end

  def parse_rows
    rows = @puzzle_string.split("\n")
    rows = rows.delete_if { |row| row == ROW_SPACER }
    @rows = rows.inject([]) do |result, element|
      values = element.gsub("|", "").split(" ").map(&:to_i)
      row = values.map {|v| v == 0 ? nil : v}
      result << Group.new(row)
    end
  end

  def parse_cols
    @cols = array_cols.inject([]) do |result, col|
      result << Group.new(col)
    end
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
    array_rows.transpose
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

  %w(rows cols boxes).each do |group|
    %w(complete? valid?).each do |method|
      define_method "#{group}_#{method}" do
        instance_variable_get("@#{group}").all? {|g| g.send(method.to_sym)}
      end
    end
  end
end

