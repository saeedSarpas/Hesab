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

  module Constants
    # SI Base Units
    Metre   = VahedPaye.new :m, :L
    Gram    = VahedPaye.new :g, :M
    Second  = VahedPaye.new :s, :T
    Ampere  = VahedPaye.new :A, :I
    Kelvin  = VahedPaye.new :K, :Th
    Mole    = VahedPaye.new :mol, :N
    Candela = VahedPaye.new :cd, :J

    # Some SI Derived Units
    Hertz     = VahedPaye.new :Hz, **{T: -1}
    Radian    = VahedPaye.new :rad
    Steradian = VahedPaye.new :sr
    Newton    = VahedPaye.new :N, **{M: 1, L: 1, T: -2}
    Pascal    = VahedPaye.new :Pa, **{M: 1, L: -1, T: -2}
    Joule     = VahedPaye.new :J, **{M: 1, L: 2, T: -2}
    Watt      = VahedPaye.new :W, **{M: 1, L: 2, T: -3}
    Coulomb   = VahedPaye.new :C, **{T: 1, I: 1}
    Volt      = VahedPaye.new :V, **{M: 1, L: 2, T: -3, I: -1}
    Farad     = VahedPaye.new :F, **{M: -1, L: -2, T: 4, I: 2}
    Ohm       = VahedPaye.new :omega, **{M: 1, L: 2, T: -3, I: -2}
    Tesla     = VahedPaye.new :T, **{M: 1, T: -2, I: -1}
    Lux       = VahedPaye.new :lx, **{J: 1, L: -2}

    # Other Base Units
    Parsec = VahedPaye.new :pc, **{L: 1}
    Msun   = VahedPaye.new :Msun, **{M: 1}
    Year   = VahedPaye.new :yr, **{T: 1}

    def self.constants
      {{ @type.constants }}
    end
  end

  include Constants

  CONSTS     = Constants.constants.map { |c| {c.symbol, c} }.to_h
  CONSTS_STR = Constants.constants.map { |c| {c.symbol.to_s, c} }.to_h
end
