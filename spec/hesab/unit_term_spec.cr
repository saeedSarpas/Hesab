require "../spec_helper"

describe UnitTerm do
  it "should be constructable with prefix, symbol, power" do
    UnitTerm.new(Prefix::Kilo, :g, 1).should be_a(UnitTerm)
    UnitTerm.new(prefix: Prefix::Kilo, symbol: :g, power: 1).should be_a(UnitTerm)
  end

  it "should be a struct" do
    UnitTerm.new(Prefix::Kilo, :g, 1).is_a?(Struct).should be_true
  end

  it "should expose prefix" do
    UnitTerm.new(Prefix::Kilo, :g, 1).prefix.should eq(Prefix::Kilo)
  end

  it "should expose symbol" do
    UnitTerm.new(Prefix::Kilo, :g, 1).symbol.should eq(:g)
  end

  it "should expose power" do
    UnitTerm.new(Prefix::Kilo, :g, 1).power.should eq(1)
  end

  it "should be constructibe from base unit symbol" do
    m = UnitTerm.from_sym(:m)
    m.should be_a(UnitTerm)
    m.prefix.should eq(Prefix::One)
    m.symbol.should eq(:m)
    m.power.should eq(1)

    pc = UnitTerm.from_sym(:pc)
    pc.should be_a(UnitTerm)
    pc.prefix.should eq(Prefix::One)
    pc.symbol.should eq(:pc)
    pc.power.should eq(1)
  end

  it "should be constructible from derived unit symbol" do
    j = UnitTerm.from_sym(:J)
    j.should be_a(UnitTerm)
    j.prefix.should eq(Prefix::One)
    j.symbol.should eq(:J)
    j.power.should eq(1)

    hz = UnitTerm.from_sym(:Hz)
    hz.should be_a(UnitTerm)
    hz.prefix.should eq(Prefix::One)
    hz.symbol.should eq(:Hz)
    hz.power.should eq(1)
  end

  pending "should be constructible from compound unit symbol" do
    kg = UnitTerm.from_sym(:kg)
    kg.should be_a(UnitTerm)
    kg.prefix.should eq(Prefix::Kilo)
    kg.symbol.should eq(:g)
    kg.power.should eq(1)

    dahz = UnitTerm.from_sym(:daHz)
    dahz.should be_a(UnitTerm)
    dahz.prefix.should eq(Prefix::Deca)
    dahz.symbol.should eq(:Hz)
    dahz.power.should eq(1)
  end
end
