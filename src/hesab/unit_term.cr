struct UnitTerm
  property prefix, symbol, power

  def initialize(@prefix : Prefix, @symbol : Symbol, @power : Int32)
  end

  def self.from_sym(sym : Symbol)
    self.new Prefix::One, sym, 1
  end
end
