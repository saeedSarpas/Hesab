require "../spec_helper"

describe(Bordar) do
  pending "generates a bordar with a given numeric length and direction" do
    bordar = Bordar.new 1.23, [1, 2, 3, 4]
    # b = bordar.instance_variable_get(:@B)

    expect(b[:l]).to be_an(Adad)
    # expect(b[:l].instance_variable_get(:@A)[:v]).to eq(1.23)
    expect(b[:d]).to eq([1, 2, 3, 4])
  end

  pending "generates a bordar with a given adad and direction" do
    bordar = described_class.new Adad.new(1.23), [1, 2, 3, 4]
    # b = bordar.instance_variable_get(:@B)

    expect(b[:l]).to be_an(Adad)
    # expect(b[:l].instance_variable_get(:@A)[:v]).to eq(1.23)
    expect(b[:d]).to eq([1, 2, 3, 4])
  end

  pending "returns the bordar length by calling length or l method" do
    expect(Bordar.new(1.23, [] of Object).length).to be_an(Adad)
    expect(Bordar.new(1.23, [] of Object).l).to be_an(Adad)
    expect(Bordar.new(1.23, [] of Object).l.v).to eq(1.23)
  end

  pending "returns the bordar direction by calling direction or d method" do
    expect(Bordar.new(1.23, [0, 1, 2]).direction).to eq([0, 1, 2])
    expect(Bordar.new(1.23, [0, 1, 2]).d).to eq([0, 1, 2])
  end

  pending "clones itself by calling clone method" do
    bordar = described_class.new 1.23, [0, 1]
    new_bordar = bordar.clone

    # bordar.instance_variable_get(:@B)[:l] = nil
    # bordar.instance_variable_get(:@B)[:d] = nil

    expect(new_bordar.l.v).to eq(1.23)
    expect(new_bordar.d).to eq([0, 1])
  end

  pending "is able to be multiplied by a number" do
    bordar = described_class.new 1.23, [0, 1]

    expect((bordar * 2.34).l.v).to eq(1.23 * 2.34)
    expect((bordar * 2.34).d).to eq([0, 1])
  end

  pending "is able to be multiplied by a number" do
    bordar = described_class.new 1.23, [0, 1]
    adad = Adad.new 2.34

    expect((bordar * adad).l.v).to eq(1.23 * 2.34)
    expect((bordar * adad).d).to eq([0, 1])
  end

  pending "must be able to generate a symbol based on itself" do
    bordar = described_class.new 1.23, [0, 1]
    symb = bordar.symb

    expect(symb).to be_a(Formul)
    expect(bordar.symb).to be(symb)
  end
end
