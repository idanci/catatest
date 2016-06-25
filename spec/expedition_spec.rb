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
        rover = subject.deploy_rover(1, 2, "N")

        rover.should be_a(Rover)
        rover.position.should  == [1,2]
        rover.direction.should == "N"
        subject.rovers.should  == [rover]
      end
    end

    describe "#move_rover(rover, instructions_set)" do
      let(:rover) { subject.deploy_rover(1, 1, "N") }

      it "should be able to move a rover" do
        instructions_set = "M"
        expect do
          subject.move_rover(rover, instructions_set)
        end.to change { rover.position }.from([1,1]).to([1,2])
      end

      it "should be able to receive instructions in different formats" do
        instructions_set = ["M", "R", "M"]
        expect do
          subject.move_rover(rover, instructions_set)
        end.to change { rover.position }.from([1,1]).to([2,2])
      end

      it "should warn about invalid instructions format" do
        instructions_set = nil
        expect do
          subject.move_rover(rover, instructions_set)
        end.to raise_error(ArgumentError)
      end
    end
  end

  context "Full expedition" do

    describe "Rover executes several instructions and reports its status" do

      it "goes well" do
        rover = subject.deploy_rover(3, 3, "E", [5,5])
        subject.move_rover(rover, "MMRMMRMRRM")
        rover.position.should  == [5,1]
        rover.direction.should == "E"

        rover = subject.deploy_rover(1, 2, "N", [5,5])
        expect { subject.move_rover(rover, "LMLMLMLMM") }.to raise_error(/lost in space/)
      end
    end
  end
end
