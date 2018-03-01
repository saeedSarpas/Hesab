require "../spec_helper"

describe JomleVahed do
  it "should be constructable with prefix, symbol, power" do
    JomleVahed.new(Pishvand::Kilo, :g, 1).should be_a(JomleVahed)
    JomleVahed.new(prefix: Pishvand::Kilo, symbol: :g, power: 1).should be_a(JomleVahed)
  end

  it "should be a struct" do
    JomleVahed.new(Pishvand::Kilo, :g, 1).is_a?(Struct).should be_true
  end

  it "should expose prefix" do
    JomleVahed.new(Pishvand::Kilo, :g, 1).prefix.should eq(Pishvand::Kilo)
  end

  it "should expose symbol" do
    JomleVahed.new(Pishvand::Kilo, :g, 1).symbol.should eq(:g)
  end

  it "should expose power" do
    JomleVahed.new(Pishvand::Kilo, :g, 1).power.should eq(1)
  end

  it "should be constructibe from base unit symbol" do
    m = JomleVahed.from_sym(:m)
    m.should be_a(JomleVahed)
    m.prefix.should eq(Pishvand::One)
    m.symbol.should eq(:m)
    m.power.should eq(1)

    pc = JomleVahed.from_sym(:pc)
    pc.should be_a(JomleVahed)
    pc.prefix.should eq(Pishvand::One)
    pc.symbol.should eq(:pc)
    pc.power.should eq(1)
  end

  it "should be constructible from derived unit symbol" do
    j = JomleVahed.from_sym(:J)
    j.should be_a(JomleVahed)
    j.prefix.should eq(Pishvand::One)
    j.symbol.should eq(:J)
    j.power.should eq(1)

    hz = JomleVahed.from_sym(:Hz)
    hz.should be_a(JomleVahed)
    hz.prefix.should eq(Pishvand::One)
    hz.symbol.should eq(:Hz)
    hz.power.should eq(1)
  end

  pending "should be constructible from compound unit symbol" do
    kg = JomleVahed.from_sym(:kg)
    kg.should be_a(JomleVahed)
    kg.prefix.should eq(Pishvand::Kilo)
    kg.symbol.should eq(:g)
    kg.power.should eq(1)

    dahz = JomleVahed.from_sym(:daHz)
    dahz.should be_a(JomleVahed)
    dahz.prefix.should eq(Pishvand::Deca)
    dahz.symbol.should eq(:Hz)
    dahz.power.should eq(1)
  end

  pending "should differentiate between prefix and similar units" do
    pc = JomleVahed.from_sym :pc
    pc.should be_a(JomleVahed)
    pc.prefix.should eq(Pishvand::One)
    pc.symbol.should eq(:pc)
    pc.power.should eq(1)
  end
end
