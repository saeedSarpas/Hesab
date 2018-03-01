struct Pishvand
  property symbol, value

  def initialize(@symbol : Symbol, @value : Float64)
  end

  Yocto = self.new :y, 1e-24
  Zepto = self.new :z, 1e-21
  Atto  = self.new :a, 1e-18
  Femto = self.new :f, 1e-15
  Pico  = self.new :p, 1e-12
  Nano  = self.new :n, 1e-9
  Micro = self.new :u, 1e-6
  Milli = self.new :m, 1e-3
  Centi = self.new :c, 1e-2
  Deci  = self.new :d, 1e-1
  One   = self.new :one, 1e0
  Deca  = self.new :da, 1e1
  Hecto = self.new :h, 1e2
  Kilo  = self.new :k, 1e3
  Mega  = self.new :M, 1e6
  Giga  = self.new :G, 1e9
  Tera  = self.new :T, 1e12
  Peta  = self.new :P, 1e15
  Exa   = self.new :E, 1e18
  Zetta = self.new :Z, 1e21
  Yotta = self.new :Y, 1e24

  def self.consts
    {{ @type.constants.map { |c| @type.constant(c) }
                      .select { |c| c.class_name == "Call" &&
         c.receiver.id == "self" &&
         c.name == "new" } }}
  end

  CONSTS = self.consts.map { |c| {c.symbol, c} }.to_h
end
