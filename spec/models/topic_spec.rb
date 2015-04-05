require 'rails_helper'

describe Topic do 
  describe "scopes" do
    before do
      #adding name > 5 chars to pass validation
      @public_topic = Topic.create(name: 'The name of the topic')
      @private_topic = Topic.create(public: false, name: 'The name of the topic')
    end

    describe "publicly viewable" do
      it "returns a relation of all public topics" do
        expect(Topic.publicly_viewable).to eq([@public_topic])
      end
    end

    describe "privately_viewable" do
      it "returns a relation of all private topics" do
        expect(Topic.privately_viewable).to eq([@private_topic])
      end
    end

    describe "visible_to(user)" do
      it "returns all topics if the user is present" do
        user = true
        expect(Topic.visible_to(user)).to eq([@public_topic,@private_topic])
      end
      it "returns only public topics if user is nil" do
        #fix incomplete test where private topics coul
        expect(Topic.visible_to(nil)).to eq([@public_topic])
      end
    end
  end  
end