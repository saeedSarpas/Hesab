require "../spec_helper"

describe Pishvand do
  context "Struct" do
    it "should be constructible with value, and symbol" do
      Pishvand.new(:k, 1e3).should be_a(Pishvand)
      Pishvand.new(value: 1e3, symbol: :k).should be_a(Pishvand)
    end

    it "should be a struct" do
      Pishvand.new(:k, 1e3).is_a?(Struct).should be_true
    end

    it "should expose symbol" do
      Pishvand.new(:k, 1e3).symbol.should eq(:k)
    end

    it "should expose value" do
      Pishvand.new(:k, 1e3).value.should eq(1e3)
    end
  end

  context "Constants" do
    it "should have yocto" do
      Pishvand::Yocto.symbol.should eq(:y)
      Pishvand::Yocto.value.should eq(1e-24)
    end

    it "should have zepto" do
      Pishvand::Zepto.symbol.should eq(:z)
      Pishvand::Zepto.value.should eq(1e-21)
    end

    it "should have atto" do
      Pishvand::Atto.symbol.should eq(:a)
      Pishvand::Atto.value.should eq(1e-18)
    end

    it "should have femto" do
      Pishvand::Femto.symbol.should eq(:f)
      Pishvand::Femto.value.should eq(1e-15)
    end

    it "should have pico" do
      Pishvand::Pico.symbol.should eq(:p)
      Pishvand::Pico.value.should eq(1e-12)
    end

    it "should have nano" do
      Pishvand::Nano.symbol.should eq(:n)
      Pishvand::Nano.value.should eq(1e-9)
    end

    it "should have micro" do
      Pishvand::Micro.symbol.should eq(:u)
      Pishvand::Micro.value.should eq(1e-6)
    end

    it "should have milli" do
      Pishvand::Milli.symbol.should eq(:m)
      Pishvand::Milli.value.should eq(1e-3)
    end

    it "should have centi" do
      Pishvand::Centi.symbol.should eq(:c)
      Pishvand::Centi.value.should eq(1e-2)
    end

    it "should have deci" do
      Pishvand::Deci.symbol.should eq(:d)
      Pishvand::Deci.value.should eq(1e-1)
    end

    it "should have one" do
      Pishvand::One.symbol.should eq(:one)
      Pishvand::One.value.should eq(1e0)
    end

    it "should have deca" do
      Pishvand::Deca.symbol.should eq(:da)
      Pishvand::Deca.value.should eq(1e1)
    end

    it "should have hecto" do
      Pishvand::Hecto.symbol.should eq(:h)
      Pishvand::Hecto.value.should eq(1e2)
    end

    it "should have kilo" do
      Pishvand::Kilo.symbol.should eq(:k)
      Pishvand::Kilo.value.should eq(1e3)
    end

    it "should have mega" do
      Pishvand::Mega.symbol.should eq(:M)
      Pishvand::Mega.value.should eq(1e6)
    end

    it "should have giga" do
      Pishvand::Giga.symbol.should eq(:G)
      Pishvand::Giga.value.should eq(1e9)
    end

    it "should have tera" do
      Pishvand::Tera.symbol.should eq(:T)
      Pishvand::Tera.value.should eq(1e12)
    end

    it "should have peta" do
      Pishvand::Peta.symbol.should eq(:P)
      Pishvand::Peta.value.should eq(1e15)
    end

    it "should have exa" do
      Pishvand::Exa.symbol.should eq(:E)
      Pishvand::Exa.value.should eq(1e18)
    end

    it "should have zetta" do
      Pishvand::Zetta.symbol.should eq(:Z)
      Pishvand::Zetta.value.should eq(1e21)
    end

    it "should have yotta" do
      Pishvand::Yotta.symbol.should eq(:Y)
      Pishvand::Yotta.value.should eq(1e24)
    end
  end

  context Pishvand::CONSTS do
    it "should be a Hash" do
      Pishvand::CONSTS.should be_a(Hash(Symbol, Pishvand))
    end

    it "should contain constants" do
      Pishvand::CONSTS[:k]?.should eq(Pishvand::Kilo)
      Pishvand::CONSTS[:Y]?.should eq(Pishvand::Yotta)
    end
  end

  context "Methods" do
    it "should get the prefix" do
      Pishvand.get_prefix(:kg).should eq({Pishvand::Kilo, "g"})
    end
  end
end
