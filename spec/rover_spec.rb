require_relative "spec_helper"

describe Rover do
  subject { Rover.new(0, 0, "N") }

  describe ".new" do
    it "should know its position and direction right after deploy" do
      subject.x.should         == 0
      subject.y.should         == 0
      subject.direction.should == "N"
      subject.name.should      == "C3PO"
    end
  end

  context "public methods" do
    describe "#position" do
      it "returns rover's current position" do
        subject.position.should == [0, 0]
      end
    end
    describe "#execute_instructions_set(instructions_set)" do
      it "returns rover's current position" do
        instructions_set = ["L"]
        subject.should_receive(:execute_instruction).with(instructions_set.first)
        subject.execute_instructions_set(instructions_set)
      end
    end
  end

  context "private methods" do
    describe "#spin" do
      it "should be able to spin" do
        expect { subject.send(:spin, "L") }.to change { subject.direction }.from("N").to("W")
        expect { subject.send(:spin, "L") }.to change { subject.direction }.from("W").to("S")
        expect { subject.send(:spin, "R") }.to change { subject.direction }.from("S").to("W")
      end
    end

    describe "#move" do
      it "should be able to move" do
        expect { subject.send(:move) }.to change { subject.position }.from([0,0]).to([0,1])
        subject.send(:spin, "L")
        expect { subject.send(:move) }.to change { subject.position }.from([0,1]).to([-1,1])
      end
    end

    describe "#execute_instruction(instruction)" do
      it "should move or spin depending on instruction" do
        subject.should_receive(:move)
        subject.send(:execute_instruction, "M")
        subject.should_receive(:spin).with("L")
        subject.send(:execute_instruction, "L")
        expect { subject.send(:execute_instruction, "Z") }.to raise_error(ArgumentError)
      end
    end
  end
end
