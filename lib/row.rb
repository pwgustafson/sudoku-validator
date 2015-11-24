class Group 
  attr_reader :values
  def initialize(values)
    @values = values
  end

  def valid?
    (1..9).to_a.each do |value|
      return false if !@values.include?(value)
    end
    return true
  end

  def complete?
    !@values.include?(0)
  end

  def invalid?
    @values.size != 9
  end

end
