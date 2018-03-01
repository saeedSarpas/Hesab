require "../spec_helper"

describe Vahed do
  it "should be constructible from symbol and abaad" do
    Vahed.new(:g, {Abaad::Mass => 1}).should be_a(Vahed)
    Vahed.new(symbol: :J, abaad: {Abaad::Mass => 1, Abaad::Length => 2, Abaad::Time => -2}).should be_a(Vahed)
  end

  it "should be a struct" do
    Vahed.new(:g, {Abaad::Mass => 1}).is_a?(Struct).should be_true
  end

  it "should expose symbol" do
    Vahed.new(:g, {Abaad::Mass => 1}).symbol.should eq(:g)
  end

  it "should expose abaad" do
    Vahed.new(:g, {Abaad::Mass => 1}).abaad.should eq({Abaad::Mass => 1})
  end
end
