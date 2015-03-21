class Vote < ActiveRecord::Base
  describe "validations" do
  before do
    @vote_1 = Vote.create(value: -1)
    @vote_2 = Vote.create(value: 1)
    @vote_3 = Vote.create(value: 2)
  end
    describe "value validation" do
      it "only allows -1 or 1 as values" do

        expect(@vote_1.value)to eq(true)
        expect(@vote_2.value)to eq(true)
        expect(@vote_3.value)to eq(false)

      end
    end
  end
end
