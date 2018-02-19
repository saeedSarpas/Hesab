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
end
