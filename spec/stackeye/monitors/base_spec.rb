# frozen_string_literal: true

RSpec.describe Stackeye::Monitors::Base do

  describe '#filepath' do
    it 'ends with "/data/base.json"' do
      path = Stackeye::Monitors::Base.filepath
      expect(path.end_with?('/data/base.json')).to eq(true)
    end
  end

end
