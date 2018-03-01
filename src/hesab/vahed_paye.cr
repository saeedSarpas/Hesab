struct VahedPaye
  property symbol, abaad

  def initialize(@symbol : Symbol, @abaad : Hash(Abaad, Int32))
  end

  def self.new(symbol : Symbol, abaad : Symbol)
    self.new symbol, {Abaad.from_sym(abaad) => 1}
  end

  def self.new(symbol : Symbol, **abaad)
    abaadHash = {} of Abaad => Int32
    abaad.each do |key, val|
      abaadHash[Abaad.from_sym key] = val
    end
    self.new symbol, abaadHash
  end
end
