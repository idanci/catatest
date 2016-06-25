require_relative "spec_helper"

describe Expedition do
  subject { Expedition.new(5, 5) }

  describe ".new" do
    it "should know upper-right coordinates of the plateau in the beginning" do
      subject.corner.should == [5, 5]
    end
  end
end
