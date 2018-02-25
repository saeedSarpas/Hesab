require "../spec_helper"

describe(Unit) do
  pending "generates a unit out of a given prefix, symbol and power" do
    expect(Unit.gen_unit :one, :m, 1).to eq({prfx: :one, symb: :m, pow: 1})
  end

  pending "checks for prefixes of a given simple, derived or compount unit" do
    expect(Unit.check_for_prfx :m).to eq([:one, :m])
    expect(Unit.check_for_prfx :kg).to eq([:k, :g])
    expect(Unit.check_for_prfx :MHz).to eq([:M, :Hz])
  end
end
