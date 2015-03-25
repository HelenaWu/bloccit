require 'rails_helper'
include TestFactories

describe Vote do
  before do
    @vote_2 = Vote.create(value: 2)  
    @vote_1 =  Vote.create(value: 1) 
    @vote_n1 = Vote.create(value: -1)
  end
  describe "validations" do
    describe "value validation" do
      # it "only allows -1 or 1 as values" do
      it "Invalidates vote where value = 2" do
        expect(@vote_2.valid?).to eq(false)
      end
      it "Validates vote where value = 1" do
        expect(@vote_1.valid?).to eq(true)
      end
      it "Validates vote where value = -1" do
        expect(@vote_n1.valid?).to eq(true)
      end
    end
  end

  describe "after_save" do
    it "calls `Post#update_rank` after save" do
      post = associated_post
      vote = Vote.new(value:1, post:post)
      expect(post).to receive(:update_rank)
      vote.save
    end
  end
end