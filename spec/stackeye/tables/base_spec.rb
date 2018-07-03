# frozen_string_literal: true

RSpec.describe Stackeye::Tables::Base do

  describe '#filepath' do
    it 'return ' do
      expect(Stackeye::Tables::Base.filepath).to eq('hey')
    end
  end

end
