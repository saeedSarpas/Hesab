require "./spec_helper"

describe(Adad) do
  pending "is accessible" do
    expect(Adad.new 1.23).to be_a(Adad)
  end
end

describe(Bordar) do
  pending "is accessible" do
    expect(Adad.new 1.23, [1]).to be_a(Bordar)
  end
end

describe(Formul) do
  pending "is accessible" do
    expect(Adad.new Adad.new(1.23)).to be_a(Formul)
  end
end
