struct Pishvand
  property symbol, value

  def initialize(@symbol : Symbol, @value : Float64)
  end

  module Constants
    Yocto = Pishvand.new :y, 1e-24
    Zepto = Pishvand.new :z, 1e-21
    Atto  = Pishvand.new :a, 1e-18
    Femto = Pishvand.new :f, 1e-15
    Pico  = Pishvand.new :p, 1e-12
    Nano  = Pishvand.new :n, 1e-9
    Micro = Pishvand.new :u, 1e-6
    Milli = Pishvand.new :m, 1e-3
    Centi = Pishvand.new :c, 1e-2
    Deci  = Pishvand.new :d, 1e-1
    One   = Pishvand.new :one, 1e0
    Deca  = Pishvand.new :da, 1e1
    Hecto = Pishvand.new :h, 1e2
    Kilo  = Pishvand.new :k, 1e3
    Mega  = Pishvand.new :M, 1e6
    Giga  = Pishvand.new :G, 1e9
    Tera  = Pishvand.new :T, 1e12
    Peta  = Pishvand.new :P, 1e15
    Exa   = Pishvand.new :E, 1e18
    Zetta = Pishvand.new :Z, 1e21
    Yotta = Pishvand.new :Y, 1e24

    def self.constants
      {{ @type.constants }}
    end
  end

  include Constants

  CONSTS = Constants.constants.map { |c| {c.symbol, c} }.to_h

  private CONSTS_KEYS     = CONSTS.keys
  private CONSTS_KEYS_STR = CONSTS_KEYS.map &.to_s

  def self.get_prefix(sym : Symbol)
    sym_s = sym.to_s
    CONSTS_KEYS_STR.each_with_index do |c, i|
      if sym_s.starts_with?(c) && (c != "d" || !sym_s.starts_with?("da")) && sym_s != c
        return {CONSTS[CONSTS_KEYS[i]], sym_s.lchop(CONSTS_KEYS_STR[i])}
      end
    end
    raise ArgumentError.new "Prefix not found!"
  end

  def one?
    @value == 1.0
  end
end
