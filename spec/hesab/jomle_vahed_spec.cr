require "../spec_helper"

describe JomleVahed do
  it "should be constructable with prefix, vahed, power" do
    JomleVahed.new(Pishvand::Kilo, VahedPaye::Gram, 1).should be_a(JomleVahed)
    JomleVahed.new(prefix: Pishvand::Kilo, vahed: VahedPaye::Gram, power: 1).should be_a(JomleVahed)
  end

  it "should be a struct" do
    JomleVahed.new(Pishvand::Kilo, VahedPaye::Gram, 1).is_a?(Struct).should be_true
  end

  it "should expose prefix" do
    JomleVahed.new(Pishvand::Kilo, VahedPaye::Gram, 1).prefix.should eq(Pishvand::Kilo)
  end

  it "should expose vahed" do
    JomleVahed.new(Pishvand::Kilo, VahedPaye::Gram, 1).vahed.should eq(VahedPaye::Gram)
  end

  it "should expose power" do
    JomleVahed.new(Pishvand::Kilo, VahedPaye::Gram, 1).power.should eq(1)
  end

  it "should be constructible from prefix and vahed" do
    kg = JomleVahed.new(Pishvand::Kilo, VahedPaye::Gram)
    kg.should be_a(JomleVahed)
    kg.power.should eq(1)
  end

  it "should be constructible from the symbols of prefix and vahed" do
    kg = JomleVahed.new :k, :g
    kg2 = JomleVahed.new :k, :g, 1
    kg3 = JomleVahed.new :k, VahedPaye::Gram
    kg4 = JomleVahed.new Pishvand::Kilo, :g

    (kg == kg2).should be_true
    (kg == kg3).should be_true
    (kg == kg4).should be_true
    kg.should be_a(JomleVahed)
  end

  it "should be constructible from vahed" do
    JomleVahed.new(VahedPaye::Gram).should eq(JomleVahed.new Pishvand::One, VahedPaye::Gram)
  end

  it "should be constructibe from base unit symbol" do
    JomleVahed.new(:m).should eq(JomleVahed.new Pishvand::One, VahedPaye::Metre, 1)
    JomleVahed.new(:pc).should eq(JomleVahed.new Pishvand::One, VahedPaye::Parsec, 1)
  end

  it "should be constructible from compound unit symbol" do
    JomleVahed.new(:kg).should eq(JomleVahed.new Pishvand::Kilo, VahedPaye::Gram, 1)
    JomleVahed.new(:daHz).should eq(JomleVahed.new Pishvand::Deca, VahedPaye::Hertz, 1)
  end

  it "should be constructible from unit symbol and power" do
    JomleVahed.new(:kg, 2).should eq(JomleVahed.new Pishvand::Kilo, VahedPaye::Gram, 2)
    JomleVahed.new(:pc, 3).should eq(JomleVahed.new Pishvand::One, VahedPaye::Parsec, 3)
    JomleVahed.new(:daHz, 4).should eq(JomleVahed.new Pishvand::Deca, VahedPaye::Hertz, 4)
  end

  it "should be comparable to other JomleVaheds" do
    j1 = JomleVahed.new(:kg, 2)
    j2 = JomleVahed.new(:k, :g, 2)
    j3 = JomleVahed.new(:one, :g, 2)
    j4 = JomleVahed.new(:km, 2)
    j5 = JomleVahed.new(:km, 1)

    (j1 <=> j2).should eq(0)
    (j1 <=> j3).should eq(-1)
    (j1 <=> j4).should eq(-1)
    (j4 <=> j5).should eq(1)
    (j1 <= j2).should be_true
    (j1 < j3).should be_true
    (j4 >= j1).should be_true
    (j4 > j5).should be_true
  end
end
