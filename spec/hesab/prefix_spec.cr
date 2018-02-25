require "../spec_helper"

describe Prefix do
  context Prefix::PREFIX do
    it "should have yocto" do
      Prefix::PREFIX[:y].should eq(1e-24)
    end

    it "should have zepto" do
      Prefix::PREFIX[:z].should eq(1e-21)
    end

    it "should have atto" do
      Prefix::PREFIX[:a].should eq(1e-18)
    end

    it "should have femto" do
      Prefix::PREFIX[:f].should eq(1e-15)
    end

    it "should have pico" do
      Prefix::PREFIX[:p].should eq(1e-12)
    end

    it "should have nano" do
      Prefix::PREFIX[:n].should eq(1e-9)
    end

    it "should have micro" do
      Prefix::PREFIX[:u].should eq(1e-6)
    end

    it "should have milli" do
      Prefix::PREFIX[:m].should eq(1e-3)
    end

    it "should have centi" do
      Prefix::PREFIX[:c].should eq(1e-2)
    end

    it "should have deci" do
      Prefix::PREFIX[:d].should eq(1e-1)
    end

    it "should have one" do
      Prefix::PREFIX[:one].should eq(1e0)
    end

    it "should have deca" do
      Prefix::PREFIX[:da].should eq(1e1)
    end

    it "should have hecto" do
      Prefix::PREFIX[:h].should eq(1e2)
    end

    it "should have kilo" do
      Prefix::PREFIX[:k].should eq(1e3)
    end

    it "should have mega" do
      Prefix::PREFIX[:M].should eq(1e6)
    end

    it "should have giga" do
      Prefix::PREFIX[:G].should eq(1e9)
    end

    it "should have tera" do
      Prefix::PREFIX[:T].should eq(1e12)
    end

    it "should have peta" do
      Prefix::PREFIX[:P].should eq(1e15)
    end

    it "should have exa" do
      Prefix::PREFIX[:E].should eq(1e18)
    end

    it "should have zetta" do
      Prefix::PREFIX[:Z].should eq(1e21)
    end

    it "should have yotta" do
      Prefix::PREFIX[:Y].should eq(1e24)
    end
  end
end
