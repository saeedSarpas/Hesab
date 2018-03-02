require "../spec_helper"

describe VahedPaye do
  it "should be constructible from symbol and abaad" do
    VahedPaye.new(:g, {Abaad::Mass => 1}).should be_a(VahedPaye)
    VahedPaye.new(symbol: :J, abaad: {Abaad::Mass => 1, Abaad::Length => 2, Abaad::Time => -2}).should be_a(VahedPaye)
  end

  it "should be constructible from the symbol of a abaad" do
    VahedPaye.new(:g, :L).should be_a(VahedPaye)
    VahedPaye.new(symbol: :g, abaad: :L).should be_a(VahedPaye)
    VahedPaye.new(:g, :L).abaad.should eq({Abaad::Length => 1})
  end

  it "should be constructible from a dictionary of abaad" do
    # It seems crystal compiler can't handle named params with capital letters for now
    abaad = {M: 1, L: 2, T: -2}
    joule = VahedPaye.new :J, **abaad
    joule.should be_a(VahedPaye)
    joule.abaad.should eq({
      Abaad::Mass   => 1,
      Abaad::Length => 2,
      Abaad::Time   => -2,
    })
  end

  it "should be a struct" do
    VahedPaye.new(:g, {Abaad::Mass => 1}).is_a?(Struct).should be_true
  end

  it "should expose symbol" do
    VahedPaye.new(:g, {Abaad::Mass => 1}).symbol.should eq(:g)
  end

  it "should expose abaad" do
    VahedPaye.new(:g, {Abaad::Mass => 1}).abaad.should eq({Abaad::Mass => 1})
  end

  it "should expose constants" do
    VahedPaye::Metre.should be_a(VahedPaye)
    VahedPaye::Gram.should be_a(VahedPaye)
    VahedPaye::Second.should be_a(VahedPaye)
    VahedPaye::Ampere.should be_a(VahedPaye)
    VahedPaye::Kelvin.should be_a(VahedPaye)
    VahedPaye::Mole.should be_a(VahedPaye)
    VahedPaye::Candela.should be_a(VahedPaye)
    VahedPaye::Hertz.should be_a(VahedPaye)
    VahedPaye::Radian.should be_a(VahedPaye)
    VahedPaye::Steradian.should be_a(VahedPaye)
    VahedPaye::Newton.should be_a(VahedPaye)
    VahedPaye::Pascal.should be_a(VahedPaye)
    VahedPaye::Joule.should be_a(VahedPaye)
    VahedPaye::Watt.should be_a(VahedPaye)
    VahedPaye::Coulomb.should be_a(VahedPaye)
    VahedPaye::Volt.should be_a(VahedPaye)
    VahedPaye::Farad.should be_a(VahedPaye)
    VahedPaye::Ohm.should be_a(VahedPaye)
    VahedPaye::Tesla.should be_a(VahedPaye)
    VahedPaye::Lux.should be_a(VahedPaye)
    VahedPaye::Parsec.should be_a(VahedPaye)
    VahedPaye::Msun.should be_a(VahedPaye)
    VahedPaye::Year.should be_a(VahedPaye)
  end

  it "should expose constants by symbol" do
    [:m, :g, :s, :A, :K, :mol, :cd, :Hz, :rad, :sr,
     :N, :Pa, :J, :W, :C, :V, :F, :omega, :T, :lx,
     :pc, :Msun, :yr].each do |u|
      VahedPaye::CONSTS[u].should be_a(VahedPaye)
    end
  end
end
