struct JomleVahed
  property prefix : Pishvand, vahed : VahedPaye, power

  def initialize(prefix : Pishvand | Symbol, vahed : VahedPaye | Symbol, @power : Int32 = 1)
    @prefix = prefix.is_a?(Symbol) ? Pishvand::CONSTS[prefix] : prefix
    @vahed = vahed.is_a?(Symbol) ? VahedPaye::CONSTS[vahed] : vahed
  end

  def self.new(vahed : VahedPaye | Symbol, power : Int32 = 1)
    if vahed.is_a?(VahedPaye) || VahedPaye::CONSTS.has_key?(vahed)
      self.new Pishvand::One, vahed, power
    else
      pish, v = Pishvand.get_prefix(vahed).not_nil!
      self.new pish, VahedPaye::CONSTS_STR[v], power
    end
  end

  def <=>(other : self)
    {@prefix.symbol, @vahed.symbol, @power} <=>
      {other.prefix.symbol, other.vahed.symbol, other.power}
  end
end
