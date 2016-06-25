require_relative "spec_helper"

describe Expedition do
  subject { Expedition.new(5, 5) }

  describe ".new" do
    it "should know upper-right coordinates of the plateau in the beginning" do
      subject.corner.should == [5, 5]
    end
  end
  context "public methods" do
    describe "#deploy_rover" do
      it "should be able to deploy a rover" do
        rover = subject.deploy_rover(1,2,"N")

        rover.should be_a(Rover)
        rover.position.should  == [1,2]
        rover.direction.should == "N"
      end
    end
    describe "#move_rover(rover, instructions_set)" do
      let(:rover) { subject.deploy_rover(0,0,"N") }
      it "should be able to move a rover" do
        instructions_set = "M"
        expect do
          subject.move_rover(rover, instructions_set)
        end.to change { rover.position }.from([0,0]).to([0,1])
      end
      it "should be able to receive instructions in different formats" do
        instructions_set = ["M", "L", "M"]
        expect do
          subject.move_rover(rover, instructions_set)
        end.to change { rover.position }.from([0,0]).to([-1,1])
      end
      it "should warn about invalid instructions format" do
        instructions_set = nil
        expect do
          subject.move_rover(rover, instructions_set)
        end.to raise_error(ArgumentError)
      end
    end
  end
end
