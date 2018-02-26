require "../spec_helper"

describe Prefix do
  context "Struct" do
    it "should be constructible with value, and symbol" do
      Prefix.new(:k, 1e3).should be_a(Prefix)
      Prefix.new(value: 1e3, symbol: :k).should be_a(Prefix)
    end

    it "should be a struct" do
      Prefix.new(:k, 1e3).is_a?(Struct).should be_true
    end

    it "should expose symbol" do
      Prefix.new(:k, 1e3).symbol.should eq(:k)
    end

    it "should expose value" do
      Prefix.new(:k, 1e3).value.should eq(1e3)
    end
  end

  context "Constants" do
    it "should have yocto" do
      Prefix::Yocto.symbol.should eq(:y)
      Prefix::Yocto.value.should eq(1e-24)
    end

    it "should have zepto" do
      Prefix::Zepto.symbol.should eq(:z)
      Prefix::Zepto.value.should eq(1e-21)
    end

    it "should have atto" do
      Prefix::Atto.symbol.should eq(:a)
      Prefix::Atto.value.should eq(1e-18)
    end

    it "should have femto" do
      Prefix::Femto.symbol.should eq(:f)
      Prefix::Femto.value.should eq(1e-15)
    end

    it "should have pico" do
      Prefix::Pico.symbol.should eq(:p)
      Prefix::Pico.value.should eq(1e-12)
    end

    it "should have nano" do
      Prefix::Nano.symbol.should eq(:n)
      Prefix::Nano.value.should eq(1e-9)
    end

    it "should have micro" do
      Prefix::Micro.symbol.should eq(:u)
      Prefix::Micro.value.should eq(1e-6)
    end

    it "should have milli" do
      Prefix::Milli.symbol.should eq(:m)
      Prefix::Milli.value.should eq(1e-3)
    end

    it "should have centi" do
      Prefix::Centi.symbol.should eq(:c)
      Prefix::Centi.value.should eq(1e-2)
    end

    it "should have deci" do
      Prefix::Deci.symbol.should eq(:d)
      Prefix::Deci.value.should eq(1e-1)
    end

    it "should have one" do
      Prefix::One.symbol.should eq(:one)
      Prefix::One.value.should eq(1e0)
    end

    it "should have deca" do
      Prefix::Deca.symbol.should eq(:da)
      Prefix::Deca.value.should eq(1e1)
    end

    it "should have hecto" do
      Prefix::Hecto.symbol.should eq(:h)
      Prefix::Hecto.value.should eq(1e2)
    end

    it "should have kilo" do
      Prefix::Kilo.symbol.should eq(:k)
      Prefix::Kilo.value.should eq(1e3)
    end

    it "should have mega" do
      Prefix::Mega.symbol.should eq(:M)
      Prefix::Mega.value.should eq(1e6)
    end

    it "should have giga" do
      Prefix::Giga.symbol.should eq(:G)
      Prefix::Giga.value.should eq(1e9)
    end

    it "should have tera" do
      Prefix::Tera.symbol.should eq(:T)
      Prefix::Tera.value.should eq(1e12)
    end

    it "should have peta" do
      Prefix::Peta.symbol.should eq(:P)
      Prefix::Peta.value.should eq(1e15)
    end

    it "should have exa" do
      Prefix::Exa.symbol.should eq(:E)
      Prefix::Exa.value.should eq(1e18)
    end

    it "should have zetta" do
      Prefix::Zetta.symbol.should eq(:Z)
      Prefix::Zetta.value.should eq(1e21)
    end

    it "should have yotta" do
      Prefix::Yotta.symbol.should eq(:Y)
      Prefix::Yotta.value.should eq(1e24)
    end
  end
end
