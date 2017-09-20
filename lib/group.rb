class Group 
  attr_accessor :values

  def initialize(values)
    @values = Array(values)
    parse_values
  end

  def parse_values
    @values = @values.delete_if {|v| v.to_i > 9 || v.to_i < 0}
    @values = @values.map { |v| v == 0 ? nil : v }
  end

  def valid?
    (@values.compact == @values.compact.uniq) && @values.size == 9
  end

  def complete?
    @values.compact.sort == [1,2,3,4,5,6,7,8,9]
  end

end

