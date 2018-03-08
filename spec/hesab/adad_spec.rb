require 'spec_helper'

describe(Adad) do
  it 'generates a new adad with only a number' do
    adad = described_class.new 1.23
    a = adad.instance_variable_get(:@A)

    expect(adad).to be_an(Adad)
    expect(a[:v]).to eq(1.23)
    [:L, :M, :T, :Th, :N].each { |dim| expect(a[:u][dim]).to be_empty }
    expect(a[:e]).to eq([0.0, 0.0])
  end

  it 'can generate an adad with nil value' do
    adad = described_class.new(nil, :km, 1)
    expect(adad).to be_an(Adad)
    expect(adad.instance_variable_get(:@A)[:v]).to be_nil
  end

  it 'generates a new adad with a number and its units' do
    adad = described_class.new 1.23, :km, 1
    a = adad.instance_variable_get(:@A)

    expect(adad).to be_an(Adad)
    expect(a[:v]).to eq(1.23)
    [:M, :T, :Th, :N].each { |dim| expect(a[:u][dim]).to be_empty }
    expect(a[:u][:L]).to eq( [Unit::gen_unit(:k, :m, 1)] )
    expect(a[:e]).to eq([0.0, 0.0])
  end

  it 'generates a new adad with a number, its uncertainties and units' do
    adad = described_class.new 1.23, [0.01, 0.02], :km, 1, :s, -1
    a = adad.instance_variable_get(:@A)

    expect(adad).to be_an(Adad)
    expect(a[:v]).to eq(1.23)
    [:M, :Th, :N].each { |dim| expect(a[:u][dim]).to be_empty }
    expect(a[:u][:L]).to eq( [Unit::gen_unit(:k, :m, 1)] )
    expect(a[:u][:T]).to eq( [Unit::gen_unit(:one, :s, -1)] )
    expect(a[:e]).to eq([0.01, 0.02])
  end

  it 'accepts single uncertainty for a adad' do
    adad = described_class.new 1.23, [0.001], :km, 1, :s, -1
    a = adad.instance_variable_get(:@A)

    expect(a[:e]).to eq([0.001, 0.001])
  end

  it 'returns the value of adad by calling value or v method' do
    adad = described_class.new 1.23
    expect(adad.value).to eq(1.23)
    expect(adad.v).to eq(1.23)
  end

  it 'returns a string containing the adad unit by calling unit or u method' do
    adad = described_class.new 1.23, :km, 2
    expect(adad.unit).to eq('[ km^2 ]')
    expect(adad.u).to eq('[ km^2 ]')
  end

  it 'return the adad uncertainties by calling e method' do
    expect(described_class.new(1.23, [0.1, 0.2]).e).to eq([0.1, 0.2])
  end

  it 'clones itself by calling clone method' do
    adad = described_class.new 1.23, [0.123], :km, 1, :s, -1
    new_adad = adad.clone

    adad.instance_variable_get(:@A)[:v] = nil
    adad.instance_variable_get(:@A)[:u] = nil
    adad.instance_variable_get(:@A)[:e] = nil

    expect(new_adad.v).to eq(1.23)
    expect(new_adad.u).to eq('[ km s^-1 ]')
    expect(new_adad.e).to eq([0.123, 0.123])
  end

  it 'is addable only by another Adad with the same dimension' do
    adad1 = described_class.new 1.23, [0.1, 0.2], :km, 1, :s, -1
    adad2 = described_class.new 2.34, [0.3, 0.4], :pc, 1, :yr, -1
    adad3 = described_class.new 3.45, [0.5, 0.6], :K, 1

    expect{adad1 + 1.23}.to raise_error(ArgumentError)

    expect(adad1 + adad2).to be_an(Adad)
    f = 3.086e13 / 3.154e7
    expect((adad1 + adad2).v.round).to eq((1.23 + (2.34 * f)).round)
    expect((adad1 + adad2).u).to eq('[ km s^-1 ]')
    expect((adad1 + adad2).e).to eq([0.1 + f * 0.3, 0.2 + f * 0.4])

    expect{adad1 + adad3}.to raise_error(ArgumentError)
  end

  it 'is subtractable only by another Adad with the same dimension' do
    adad1 = described_class.new 1.23, [0.1, 0.2], :km, 1, :s, -1
    adad2 = described_class.new 2.34, [0.3, 0.4], :pc, 1, :yr, -1
    adad3 = described_class.new 3.45, [0.5, 0.6], :K, 1

    expect{adad1 - 1.23}.to raise_error(ArgumentError)

    expect(adad1 + adad2).to be_an(Adad)
    f = 3.086e13 / 3.154e7
    expect((adad1 - adad2).v.round).to eq((1.23 - (2.34 * f)).round)
    expect((adad1 - adad2).u).to eq('[ km s^-1 ]')
    expect((adad1 - adad2).e).to eq([0.1 + f * 0.3, 0.2 + f * 0.4])
  end

  it 'can be multiplied by a number' do
    adad = described_class.new 1.23, [0.1, 0.2], :km, 1, :s, -1

    expect((adad * 2).v).to eq(1.23 * 2)
    expect((adad * 2).u).to eq('[ km s^-1 ]')
    expect((adad * 2).e).to eq([0.2, 0.4])
  end

  it 'can be multiplied by an adad' do
    adad1 = described_class.new 1.23, [0.1, 0.2], :km, 1, :s, -1
    adad2 = described_class.new 2.34, [0.3, 0.4], :s, 1

    expect((adad1 * adad2).v).to eq(1.23 * 2.34)
    expect((adad1 * adad2).u).to eq('[ km s^-1 s ]')
    expect((adad1 * adad2).e).to eq([
      2.34 * 0.1 + 1.23 * 0.3,
      2.34 * 0.2 + 1.23 * 0.4,
    ])
  end

  it 'is dividable by a number' do
    adad = described_class.new 1.23, [0.2, 0.4], :km, 1, :s, -1

    expect((adad / 2).v).to eq(1.23 / 2)
    expect((adad / 2).u).to eq('[ km s^-1 ]')
    expect((adad / 2).e).to eq([0.1, 0.2])
  end

  it 'is dividable by an adad' do
    adad1 = described_class.new 1.23, [0.1, 0.2], :km, 1, :s, -1
    adad2 = described_class.new 2.34, [0.3, 0.4], :s, 1

    expect((adad1 / adad2).v).to eq(1.23 / 2.34)
    expect((adad1 / adad2).u).to eq('[ km s^-1 s^-1 ]')
    expect((adad1 / adad2).e).to eq([
      2.34 * 0.1 + 1.23 * 0.3,
      2.34 * 0.2 + 1.23 * 0.4,
    ])
  end

  it 'is Exponentiable by a given scalar' do
    adad = described_class.new 1.23, [0.1, 0.2], :km, 1, :s, -1

    expect((adad**3.45).v).to eq(1.23**3.45)
    expect((adad**3.45).u).to eq('[ km^3.45 s^-3.45 ]')
    expect((adad**3.45).e).to eq([0.1 * 3.45, 0.2 * 3.45])
  end

  it 'simplifies its own units by calling simplify! method' do
    adad = described_class.new(67.74, :km, 1, :Mpc, -1, :s, -1)
    adad.simplify!

    [:L, :M, :Th, :N].each do |d|
      expect(adad.instance_variable_get(:@A)[:u][d]).to be_empty
    end

    expect(adad.instance_variable_get(:@A)[:u][:T]).to eq(
      [Unit::gen_unit(:one, :s, -1)]
    )
  end

  it 'converts itself to an arbitrary unit' do
    adad = described_class.new 1.0, :kg, 1, :m, 1, :s, -2

    converted = adad.to(:g, 1, :cm, 1, :s, -2)
    converted_a = converted.instance_variable_get(:@A)

    [:Th, :N].each { |d| expect(converted_a[:u][d]).to be_empty }
    expect(converted_a[:u][:L]).to eq([Unit::gen_unit(:c, :m, 1)])
    expect(converted_a[:u][:M]).to eq([Unit::gen_unit(:one, :g, 1)])
    expect(converted_a[:u][:T]).to eq([Unit::gen_unit(:one, :s, -2)])
    expect(converted.v).to eq(1.0e5)


    reverted = converted.to(:N, 1)
    reverted_a = reverted.instance_variable_get(:@A)

    [:Th, :N].each { |d| expect(reverted_a[:u][d]).to be_empty }
    expect(reverted_a[:u][:L]).to eq([Unit::gen_unit(:one, :m, 1)])
    expect(reverted_a[:u][:M]).to eq([Unit::gen_unit(:k, :g, 1)])
    expect(reverted_a[:u][:T]).to eq([Unit::gen_unit(:one, :s, -2)])
    expect(reverted.v).to eq(1.0)
  end

  it 'can generate a symbol based on itself' do
    adad = described_class.new 1.23, :km, 1
    symb = adad.symb

    expect(symb).to be_a(Formul)
    expect(adad.symb).to be(symb)
    expect(adad.symb.instance_variable_get(:@F).v).to eq(1.23)

    adad.instance_variable_get(:@A)[:v] = 2.34
    expect(adad.symb.instance_variable_get(:@F).v).to eq(2.34)
  end
end
