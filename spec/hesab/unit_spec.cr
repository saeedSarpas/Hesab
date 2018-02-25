require "../spec_helper"

describe(Unit) do
  it "generates a unit out of a given prefix, symbol and power" do
    Unit.gen_unit(:one, :m, 1).should eq({prfx: :one, symb: :m, pow: 1})
  end

  it "checks for prefixes of a given simple unit" do
    Unit.check_for_prfx(:m).should eq({:one, :m})
  end

  pending "checks for prefixes of a given compound unit" do
    Unit.check_for_prfx(:kg).should eq({:k, :g})
    Unit.check_for_prfx(:MHz).should eq({:M, :Hz})
  end
end
