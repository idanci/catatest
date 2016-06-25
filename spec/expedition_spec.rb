require_relative "spec_helper"

describe Expedition do
  subject { Expedition.new(5, 5) }

  describe ".new" do
    it "should know upper-right coordinates of the plateau in the beginning" do
      subject.corner.should == [5, 5]
    end
  end
  context "public methods" do
    describe "#deploy" do
      it "should be able to deploy a rover" do
        rover = subject.deploy(1,2,"N")

        rover.should be_a(Rover)
        rover.position.should  == [1,2]
        rover.direction.should == "N"
      end
    end
  end
end
