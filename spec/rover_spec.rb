require_relative "spec_helper"

describe Rover do
  subject { Rover.new([0, 0], "N") }

  it "should know its position and direction right after deploy" do
    subject.position.should  == [0, 0]
    subject.direction.should == "N"
  end

  it "should be able to spin" do
    expect { subject.spin("L") }.to change { subject.direction }.from("N").to("W")
    expect { subject.spin("L") }.to change { subject.direction }.from("W").to("S")
    expect { subject.spin("R") }.to change { subject.direction }.from("S").to("W")
  end
end
