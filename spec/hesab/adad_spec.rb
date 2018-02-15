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
end
