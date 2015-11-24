require_relative "../lib/row.rb"

describe 'Row' do
  context 'row parsing' do
    it 'parses a valid row' do
      row_string = "1 2 3 | 4 5 6 | 7 8 9"
      row_array = [1,2,3,4,5,6,7,8,9]
      row = Row.new(row_string) 
      expect(row.values).to eq row_array
    end  

    it 'parses an incomplete row' do
      row_string = "1 2 0 | 4 5 6 | 0 0 8"
      row_array = [1,2,nil,4,5,6,nil,nil,8] 
      row = Row.new(row_string)
      expect(row.values).to eq row_array
    end
  end
  context 'Validating' do
    it 'returns true for a valid row' do
      row_string = "1 2 3 | 4 5 6 | 7 8 9"
      row = Row.new(row_string)
      expect(row.valid?).to eq true
    end

    it 'returns false for an invalid row' do
      row_string = "1 2 3 | 4 5 7 | 7 8 9"
      row = Row.new(row_string)
      expect(row.valid?).to eq false
    end
  end
end
