require 'rails_helper'

describe Vote do
  before do
    @vote = Vote.create(value: 2)    
  end
  describe "validations" do
    describe "value validation" do
      it "only allows -1 or 1 as values" do
        expect(@vote.valid?).to eq(false)
      end
    end
  end
end