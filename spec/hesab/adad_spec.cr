require "../spec_helper"

describe(Adad) do
  it "should be constructible from value, epsilon, and vahed" do
    Adad.new(1.23, {0.0, 0.0}, [] of JomleVahed).should be_a(Adad)
    Adad.new(value: 1.23, epsilon: {0.0, 0.0}, vahed: [] of JomleVahed).should be_a(Adad)
  end

  it "should be a struct" do
    Adad.new(1.23, {0.0, 0.0}, [] of JomleVahed).is_a?(Struct).should be_true
  end

  it "should expose value and v" do
    adad = Adad.new(1.23, {0.0, 0.0}, [] of JomleVahed)
    adad.value.should eq(1.23)
    adad.v.should eq(1.23)
  end

  it "should expose epsilon and e" do
    Adad.new(1.23, {0.0, 0.0}, [] of JomleVahed).epsilon.should eq({0.0, 0.0})
  end

  it "should expose vahed" do
    Adad.new(1.23, {0.0, 0.0}, [] of JomleVahed).vahed.should eq([] of JomleVahed)
  end

  it "should be constructible from value and epsilon" do
    adad = Adad.new(1.23, {0.0, 0.0})
    adad.should be_a(Adad)
    adad.value.should eq(1.23)
    adad.epsilon.should eq({0.0, 0.0})
    adad.vahed.should eq([] of JomleVahed)
  end

  it "should be constructible from value" do
    adad = Adad.new(1.23)
    adad.should be_a(Adad)
    adad.value.should eq(1.23)
    adad.epsilon.should eq({0.0, 0.0})
    adad.vahed.should eq([] of JomleVahed)
  end

  it "should be constructible from value, and vahed" do
    adad = Adad.new(1.23, vahed: [JomleVahed.new :kg])
    adad.should be_a(Adad)
    adad.value.should eq(1.23)
    adad.epsilon.should eq({0.0, 0.0})
    adad.vahed.should eq([JomleVahed.new :kg])
  end

  it "should be constructible from value and vahed expression" do
    Adad.new(1.23, km: 1, mHz: -2).should eq(Adad.new(
      value: 1.23,
      epsilon: {0.0, 0.0},
      vahed: [
        JomleVahed.new(:k, :m, 1),
        JomleVahed.new(:m, :Hz, -2),
      ]
    ))
  end

  it "should be constructible from value, epsilon, and vahed expression" do
    Adad.new(1.23, {0.01, 0.02}, km: 1, mHz: -2).should eq(Adad.new(
      value: 1.23,
      epsilon: {0.01, 0.02},
      vahed: [
        JomleVahed.new(:k, :m, 1),
        JomleVahed.new(:m, :Hz, -2),
      ]
    ))
  end

  it "should be constructible from single value for epsilon" do
    Adad.new(1.23, {0.01}, [JomleVahed.new :g]).epsilon.should eq({0.01, 0.01})
    Adad.new(1.23, {0.01}, km: 1).epsilon.should eq({0.01, 0.01})
  end

  it "should make string rep. of vahed" do
    adad = Adad.new 1.23, kg: 1, m: -1, J: -3, A: 2
    adad.vahed_str.should eq("[ kg m^-1 J^-3 A^2 ]")
    adad.vstr.should eq("[ kg m^-1 J^-3 A^2 ]")
  end

  it "should calculate the dimension" do
    adad = Adad.new 1.23, kg: 1
    adad.abaad.should eq({Abaad::Mass => 1})

    adad = Adad.new 1.23, kg: 1, m: -1, s: -3
    adad.abaad.should eq({
      Abaad::Length => -1, Abaad::Mass => 1, Abaad::Time => -3,
    })

    adad = Adad.new 1.23, kg: 1, m: -1, J: -3, W: 2
    adad.abaad.should eq({
      Abaad::Mass => 0, Abaad::Length => -3, Abaad::Time => 0,
    })
  end

  it "should check that two adads have dimensions" do
    adad1 = Adad.new 1.23, {0.1, 0.2}, km: 1, s: -1
    adad2 = Adad.new 2.34, {0.3, 0.4}, pc: 1, yr: -1
    adad3 = Adad.new 3.45, {0.5, 0.6}, **{K: 1}

    adad1.same_dimension?(adad2).should be_true
    adad1.same_dimension?(adad3).should be_false
  end

  it "should check that two adads have same units" do
    adad1 = Adad.new 1.23, kg: 1, s: 2
    adad2 = Adad.new 1.23, s: 1, kg: 2
    adad3 = Adad.new 1.23, s: 2, kg: 1

    adad1.same_vahed?(adad2).should be_false
    adad1.same_vahed?(adad3).should be_true
  end

  it "should be possible to add another adad" do
    adad1 = Adad.new 1.23, {0.1, 0.2}, km: 1, s: -1
    adad2 = Adad.new 2.34, {0.3, 0.4}, pc: 1, yr: -1
    adad3 = Adad.new 3.45, {0.5, 0.6}, **{K: 1}
    adad4 = Adad.new 4.56, {0.7, 0.8}, km: 1, s: -1

    expect_raises(ArgumentError) { adad1 + adad2 }
    expect_raises(ArgumentError) { adad1 + adad3 }

    (adad1 + adad4).should be_a(Adad)
    (adad1 + adad4).v.should eq(1.23 + 4.56)
    (adad1 + adad4).vstr.should eq("[ km s^-1 ]")
    (adad1 + adad4).e.should eq({0.1 + 0.7, 0.2 + 0.8})
  end

  it "should be possible to multiply by a number" do
    adad = Adad.new 1.23, {0.1, 0.2}, km: 1, s: -1

    (adad * -2).v.should eq(1.23 * -2)
    (adad * -2).vstr.should eq("[ km s^-1 ]")
    (adad * -2).e.should eq({0.2, 0.4})
  end

  it "should be possible to multiply by an adad" do
    adad1 = Adad.new 1.23, {0.1, 0.2}, km: 1, s: -1
    adad2 = Adad.new -2.34, {0.3, 0.4}, s: 1

    (adad1 * adad2).v.should eq(1.23 * -2.34)
    (adad1 * adad2).vstr.should eq("[ km s^-1 s ]")
    (adad1 * adad2).e.should eq({
      2.34 * 0.1 + 1.23 * 0.3,
      2.34 * 0.2 + 1.23 * 0.4,
    })
  end

  it "should be possible to subtract" do
    adad1 = Adad.new 1.23, {0.1, 0.2}, km: 1, s: -1
    adad2 = Adad.new 2.34, {0.3, 0.4}, pc: 1, yr: -1
    adad3 = Adad.new 3.45, {0.5, 0.6}, **{K: 1}
    adad4 = Adad.new 4.56, {0.7, 0.8}, km: 1, s: -1

    expect_raises(ArgumentError) { adad1 - adad2 }
    expect_raises(ArgumentError) { adad1 - adad3 }

    (adad1 - adad4).should be_a(Adad)
    (adad1 - adad4).v.should eq(1.23 - 4.56)
    (adad1 - adad4).vstr.should eq("[ km s^-1 ]")
    (adad1 - adad4).e.should eq({0.1 + 0.7, 0.2 + 0.8})
  end

  it "should be possible to divide by a number" do
    adad = Adad.new 1.23, {0.2, 0.4}, km: 1, s: -1

    (adad / -2).v.should eq(1.23 / -2)
    (adad / -2).vstr.should eq("[ km s^-1 ]")
    (adad / -2).e.should eq({0.1, 0.2})
  end

  it "should be possible to divide by an adad" do
    adad1 = Adad.new 1.23, {0.1, 0.2}, km: 1, s: -1
    adad2 = Adad.new -2.34, {0.3, 0.4}, s: 1

    (adad1 / adad2).v.should eq(1.23 / -2.34)
    (adad1 / adad2).vstr.should eq("[ km s^-1 s^-1 ]")
    (adad1 / adad2).e.should eq({
      2.34 * 0.1 + 1.23 * 0.3,
      2.34 * 0.2 + 1.23 * 0.4,
    })
  end

  it "should be possible to Exponentiate by a given scalar" do
    adad = Adad.new 1.23, {0.1, 0.2}, km: 1, s: -2

    (adad**3).v.should eq(1.23**3)
    (adad**3).vstr.should eq("[ km^3 s^-6 ]")
    (adad**3).e.should eq({0.1 * 3, 0.2 * 3})
  end
end
