require "../spec_helper"

describe(Bordar) do
  it "should be constructible from an Adad and a vector" do
    Bordar.new(Adad.new(1.23), [1.0, 2.0, 3.0, 4.0]).should be_a(Bordar)
  end

  it "should be constructible by a number and a vector" do
    Bordar.new(1.23, [1.0, 2.0, 3.0, 4.0]).should be_a(Bordar)
  end

  it "should be a struct" do
    Bordar.new(1.23, [1.0, 2.0, 3.0, 4.0]).is_a?(Struct).should be_true
  end

  it "should expose length and l" do
    bordar = Bordar.new(1.23, [] of Float64)

    bordar.length.should be_a(Adad)
    bordar.l.should be_a(Adad)
    bordar.l.v.should eq(1.23)
  end

  it "should expose direction and d" do
    Bordar.new(1.23, [0.0, 1.0, 2.0]).direction.should eq([0.0, 1.0, 2.0])
    Bordar.new(1.23, [0.0, 1.0, 2.0]).d.should eq([0.0, 1.0, 2.0])
  end

  it "should be possible to multiply by a number or an Adad" do
    bordar = Bordar.new 1.23, [0.0, 1.0]
    adad = Adad.new 2.34

    (bordar * 2.34).l.v.should eq(1.23 * 2.34)
    (bordar * 2.34).d.should eq([0.0, 1.0])
    (bordar * adad).l.should eq(bordar.l * adad)
    (bordar * adad).d.should eq([0.0, 1.0])
  end
end
