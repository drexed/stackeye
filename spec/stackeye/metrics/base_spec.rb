# frozen_string_literal: true

RSpec.describe Stackeye::Metrics::Base do

  describe '#filepath' do
    it 'ends with "/stackeye/base.json"' do
      path = Stackeye::Metrics::Base.filepath

      expect(path.end_with?('/stackeye/base.json')).to eq(true)
    end
  end

end
