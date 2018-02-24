module Unit
  # Generate a unit
  #
  # === Attributes
  # +prfx+:: prefix of the unit, :one, :k, :M, ...
  # +symb+:: unit symbol, :m, :s, :pc, ...
  # +pow+:: power of the unit
  def gen_unit(prfx, symb, pow)
    {prfx: prfx, symb: symb, pow: pow}
  end

  # Check if a given symbol contains any unit prefixes
  #
  # === Attributes
  # +unit+:: a symbol specifying a simple, derived or compound unit,
  #     e.g. :m, :pc, :kHz, etc.
  def check_for_prfx(unit_sym)
    return :one, unit_sym if Unit::DERIVED.key? unit_sym
    Unit::Dim.each { |d| return :one, unit_sym if Unit::UNITS[d].key? unit_sym }

    Unit::PRFX.keys.each do |p|
      u = unit_sym.to_s
      if u.start_with? p.to_s
        u[p.to_s] = ""
        return p, u.to_sym
      end
    end
  end

  # Returns conversion factor
  #
  # === Attributes
  # +unit+:: a unit similar or generated by gen_unit
  #     e.g. { prfx: :one, symb: :K, pow: 2 }
  # TODO: need to be refactored
  def conv_fact(unit)
    f = Unit::UNITS.values.select { |u| u.key? unit[:symb] }.first
    railse ArgumentError, "Unknown unit: #{unit[:symb]}" unless f

    (Unit::PRFX[unit[:prfx]] * f[unit[:symb]][:conv])**unit[:pow]
  end

  UNITS = {
    L: {
      default: gen_unit(:one, :m, 1),
      m:       {conv: 1},
      pc:      {conv: 3.086e16},
    },
    M: {
      default: gen_unit(:k, :g, 1),
      g:       {conv: 0.001},
      Msun:    {conv: 1.989e30},
    },
    T: {
      default: gen_unit(:one, :s, 1),
      s:       {conv: 1},
      yr:      {conv: 3.154e7},
    },
    Th: {
      default: gen_unit(:one, :K, 1),
      K:       {conv: 1},
    },
    N: {
      default: gen_unit(:one, :mol, 1),
      mol:     {conv: 1},
    },
  }

  Dim = UNITS.keys # Dimension Symbols

  # Derived Units
  DERIVED = {
    Hz: {T: [gen_unit(:one, :s, -1)]},
    J:  {
      M: [gen_unit(:k, :g, 1)],
      L: [gen_unit(:one, :m, 2)],
      T: [gen_unit(:one, :s, -2)],
    },
    N: {
      M: [gen_unit(:k, :g, 1)],
      L: [gen_unit(:one, :m, 1)],
      T: [gen_unit(:one, :s, -2)],
    },
    Pa: {
      M: [gen_unit(:k, :g, 1)],
      L: [gen_unit(:one, :m, -1)],
      T: [gen_unit(:one, :s, -2)],
    },
    W: {
      M: [gen_unit(:k, :g, 1)],
      L: [gen_unit(:one, :m, 2)],
      T: [gen_unit(:one, :s, -3)],
    },
  }

  # Prefixes
  PRFX = {
    E: 1e18, P: 1e15, T: 1e12, G: 1e9, M: 1e6, k: 1e3, h: 1e2, one: 1,
    d: 1e-1, c: 1e-2, m: 1e-3, u: 1e-6, n: 1e-9, p: 1e-12, f: 1e-15, a: 1e-18,
  }
end
