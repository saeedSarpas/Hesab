require 'spec_helper'

describe(Formul) do
  it 'initializes a Formul out of a given Adad or Bordar' do
    expect{described_class.new(1.23)}.to raise_error(ArgumentError)

    adad = Adad.new 1.23, :km, 1
    formul = described_class.new adad
    expect(formul).to be_a(Formul)
    expect(formul.instance_variable_get(:@F)).to be(adad)

    bordar = Bordar.new adad, [1,2,3]
    formul = described_class.new bordar
    expect(formul).to be_a(Formul)
    expect(formul.instance_variable_get(:@F)).to be(bordar)
  end

  it 'clones itself by calling clone method' do
    formul = described_class.new Adad.new(1.23, :km, 1)
    new_formul = formul.clone

    formul.instance_variable_set(:@F, nil)

    adad = new_formul.instance_variable_get(:@F)
    expect(adad).to be_an(Adad)
    expect(adad.v).to eq(1.23)
    expect(adad.u).to eq('[ km ]')
  end

  it 'is addable by other symbols/formuls' do
    f1 = Formul.new Adad.new(1.23, :km, 1)
    f2 = Formul.new Bordar.new(1.23, [1,0])

    f = f1 + f2
    expect(f).to be_a(Formul)
    expect(f.instance_variable_get(:@F)).to eq(
      {:+ => [f1.instance_variable_get(:@F), f2.instance_variable_get(:@F)]}
    )
  end

  it 'can be multiplied by another Formul' do
    f1 = Formul.new Adad.new(1.23, :km, 1)
    f2 = Formul.new Bordar.new(1.23, [1,0])

    f = f1 * f2
    expect(f).to be_a(Formul)
    expect(f.instance_variable_get(:@F)).to eq(
      {:* => [f1.instance_variable_get(:@F), f2.instance_variable_get(:@F)]}
    )
  end

  it 'can be divided by another Formul' do
    f1 = Formul.new Adad.new(1.23, :km, 1)
    f2 = Formul.new Bordar.new(1.23, [1,0])

    f = f1 / f2
    expect(f).to be_a(Formul)
    expect(f.instance_variable_get(:@F)).to eq(
      {:/ => [f1.instance_variable_get(:@F), f2.instance_variable_get(:@F)]}
    )
  end

  it 'is Exponentiable by a given scalar' do
    f1 = Formul.new Adad.new(1.23, :km, 1)
    f2 = f1**2.34
    expect(f2).to be_a(Formul)
    expect(f2.instance_variable_get(:@F)).to eq(
      {:** => [f1.instance_variable_get(:@F), 2.34]}
    )
  end

  it 'should be able to generate a formul of symbols' do
    m = Adad.new 1.23, :kg, 1
    a = Bordar.new Adad.new(2.34, :km, 1, :s, -2), [0,1]

    f = m.symb * a.symb

    expect(f).to be_a(Formul)
    expect(f.instance_variable_get(:@F)).to eq(
      {:* => [
        m.symb.instance_variable_get(:@F),
        a.symb.instance_variable_get(:@F)
      ]}
    )
  end

  it 'should be able to handle nested cases' do
    c = Adad.new 2.998e8, :m, 1, :s, -1
    m = Adad.new 1.0, :kg, 1
    p = Adad.new 1.0, :kg, 1, :m, 1, :s, -1

    E2 = (m.symb * c.symb**2)**2 + (p.symb * c.symb)**2

    c_f = c.symb.instance_variable_get(:@F)
    m_f = m.symb.instance_variable_get(:@F)
    p_f = p.symb.instance_variable_get(:@F)

    expect(E2).to be_a(Formul)

    expect(E2.instance_variable_get(:@F)).to eq({
      :+ => [
        {:** => [{:* => [m_f, {:** => [c_f, 2]}]}, 2]},
        {:** => [{:* => [p_f, c_f]}, 2]}
      ]
    })
  end
end
