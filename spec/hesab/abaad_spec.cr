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

  it "should be constructible from symbol" do
    Abaad.from_sym(:L).should eq(Abaad::Length)
    Abaad.from_sym(:M).should eq(Abaad::Mass)
    Abaad.from_sym(:T).should eq(Abaad::Time)
    Abaad.from_sym(:I).should eq(Abaad::I)
    Abaad.from_sym(:N).should eq(Abaad::N)
    Abaad.from_sym(:J).should eq(Abaad::J)
    Abaad.from_sym(:Th).should eq(Abaad::Theta)
  end
end
