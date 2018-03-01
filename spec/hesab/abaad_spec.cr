require "../spec_helper"

describe Abaad do
  it "should contain Length dimension" do
    Abaad.names.should contain("Length")
  end

  it "should contain Mass dimension" do
    Abaad.names.should contain("Mass")
  end

  it "should contain Time dimension" do
    Abaad.names.should contain("Time")
  end

  it "should contain Current dimension" do
    Abaad.names.should contain("I")
  end

  it "should contain Temperature dimension" do
    Abaad.names.should contain("Theta")
  end

  it "should contain Substance dimension" do
    Abaad.names.should contain("N")
  end

  it "should contain Luminous dimension" do
    Abaad.names.should contain("J")
  end
end
