require_relative "../lib/group.rb"

describe 'Group' do
  context 'parsing' do
    it 'parses a valid group' do
      values = [1,2,3,4,5,6,7,8,9]
      group = Group.new(values) 
      expect(group.values).to eq values
    end  

    it 'parses an incomplete group' do
      values = [1,2,0,4,5,6,0,0,8] 
      row = Group.new(values)
      expect(row.values).to eq [1,2,nil,4,5,6,nil,nil,8]
    end
  end
  context 'Validating' do
    it 'returns true for a complete group' do
      values = [1,2,3,4,5,6,7,8,9]
      group = Group.new(values)
      expect(group.complete?).to eq true
    end

    it 'returns false for an invalid group' do
      values = [1,1,3,4,5,6,7,8,9]
      group = Group.new(values)
      expect(group.valid?).to eq false
    end

    it 'returns true for an valid group containing zeros' do
      values = [1,0,3,4,5,6,7,8,9]
      group = Group.new(values)
      expect(group.valid?).to eq true
    end

    it 'returns false for an invalid group containing zeros' do
      values = [1,0,3,4,5,6,7,8,1]
      group = Group.new(values)
      expect(group.valid?).to eq false
    end

    it 'returns false if any of the numbers are greater than 9' do
      values = [10,0,3,4,5,6,7,8,1]
      group = Group.new(values)
      expect(group.valid?).to eq false
    end

    it 'returns false if any of the numbers are less than 0' do
      values = [-3,0,3,4,5,6,7,8,1]
      group = Group.new(values)
      expect(group.valid?).to eq false
    end
  end
end
