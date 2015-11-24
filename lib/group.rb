class Group 
  attr_accessor :values

  def initialize(values)
    @values = Array(values)
    parse_values
  end

  def parse_values
    @values = @values.map { |v| v == 0 ? nil : v }
  end

  def valid?
    values.compact == values.compact.uniq
  end

  def complete?
    @values.compact.sort == [1,2,3,4,5,6,7,8,9]
  end

end

