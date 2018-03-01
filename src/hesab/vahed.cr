struct Vahed
  property symbol, abaad

  def initialize(@symbol : Symbol, @abaad : Hash(Abaad, Int32))
  end

  def self.new(symbol : Symbol, abaad : Symbol)
    self.new symbol, {Abaad.from_sym(abaad) => 1}
  end
end
