require_relative "spec_helper"

describe Rover do
  subject { Rover.new(1, 1, "N", [5, 5]) }

  describe ".new" do

    it "should know its position and direction right after deploy" do
      subject.x.should          == 1
      subject.y.should          == 1
      subject.direction.should  == "N"
      subject.name.should       == "C3PO"
      subject.playground.should == [5, 5]
    end
  end

  context "public methods" do

    describe "#position" do

      it "returns rover's current position" do
        subject.position.should == [1, 1]
      end
    end

    describe "#execute_instructions_set(instructions_set)" do

      it "returns rover's current position" do
        instructions_set = ["L"]
        subject.should_receive(:execute_instruction).with(instructions_set.first)
        subject.execute_instructions_set(instructions_set)
      end

      it "sets initial coordinates back of instructions are wrong" do
        initial_x        = subject.x
        instructions_set = ["L","M","M","M"]

        expect { subject.execute_instructions_set(instructions_set) }.to raise_error(LostInSpace)
        subject.x.should == initial_x
      end
    end
  end

  context "private methods" do

    describe "#spin" do

      it "should be able to spin" do
        expect { subject.send(:spin, "L") }.to change { subject.direction }.from("N").to("W")
        expect { subject.send(:spin, "L") }.to change { subject.direction }.from("W").to("S")
        expect { subject.send(:spin, "L") }.to change { subject.direction }.from("S").to("E")
        expect { subject.send(:spin, "L") }.to change { subject.direction }.from("E").to("N")
        expect { subject.send(:spin, "L") }.to change { subject.direction }.from("N").to("W")
        expect { subject.send(:spin, "L") }.to change { subject.direction }.from("W").to("S")
      end
    end

    describe "#move" do

      it "should be able to move" do
        expect { subject.send(:move) }.to change { subject.position }.from([1,1]).to([1,2])
        subject.send(:spin, "R")
        expect { subject.send(:move) }.to change { subject.position }.from([1,2]).to([2,2])
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
