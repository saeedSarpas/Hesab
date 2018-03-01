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
end
