require "../spec_helper"

describe Dimension do
  it "should contain Length dimension" do
    Dimension.names.should contain("L")
  end

  it "should contain Mass dimension" do
    Dimension.names.should contain("M")
  end

  it "should contain Time dimension" do
    Dimension.names.should contain("T")
  end

  it "should contain Current dimension" do
    Dimension.names.should contain("I")
  end

  it "should contain Temperature dimension" do
    Dimension.names.should contain("Theta")
  end

  it "should contain Substance dimension" do
    Dimension.names.should contain("N")
  end

  it "should contain Luminous dimension" do
    Dimension.names.should contain("J")
  end
end
