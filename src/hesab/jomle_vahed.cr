struct JomleVahed
  property prefix, symbol, power

  def initialize(@prefix : Pishvand, @symbol : Symbol, @power : Int32)
  end

  def self.from_sym(sym : Symbol)
    self.new Pishvand::One, sym, 1
  end
end
