require 'spec_helper'

describe(Adad) do
  it 'is accessible' do
    expect(described_class.new 1.23).to be_a(Adad)
  end
end

describe(Bordar) do
  it 'is accessible' do
    expect(described_class.new 1.23, [1]).to be_a(Bordar)
  end
end

describe(Formul) do
  it 'is accessible' do
    expect(described_class.new Adad.new(1.23)).to be_a(Formul)
  end
end
