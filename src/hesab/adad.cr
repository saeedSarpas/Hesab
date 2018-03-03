struct Adad
  property value : Float64
  property epsilon : Tuple(Float64, Float64)
  property vahed : Array(JomleVahed)

  def initialize(
    @value,
    epsilon : Tuple(Float64) | Tuple(Float64, Float64) = {0.0, 0.0},
    @vahed = [] of JomleVahed
  )
    @epsilon = epsilon.is_a?(Tuple(Float64)) ? {epsilon[0], epsilon[0]} : epsilon
  end

  def self.new(
    value : Float64,
    epsilon : Tuple(Float64) | Tuple(Float64, Float64) = {0.0, 0.0},
    **expr : Int32
  )
    epsilon = epsilon.is_a?(Tuple(Float64)) ? {epsilon[0], epsilon[0]} : epsilon
    vahed = [] of JomleVahed
    expr.each { |s, v| vahed << JomleVahed.new s, v }
    self.new value, epsilon, vahed
  end

  def v
    @value
  end

  def e
    @epsilon
  end

  def vahed_str
    "[" +
      vahed.map do |v|
        " #{v.prefix.one? ? "" : v.prefix.symbol}#{v.vahed.symbol}" +
          ((v.power == 1) ? "" : "^#{v.power}")
      end.join +
      " ]"
  end

  def vstr
    self.vahed_str
  end

  def abaad : Hash(Abaad, Int32)
    a = ({} of Abaad => Int32)
    @vahed.each do |v|
      v.vahed.abaad.each do |abaad, power|
        r = power * v.power
        if a.has_key? abaad
          a[abaad] += r
        else
          a[abaad] = r
        end
      end
    end
    a
  end

  def same_dimension?(other : self)
    self.abaad == other.abaad
  end

  def same_vahed?(other : self)
    self.vahed.sort == other.vahed.sort
  end

  def +(other : self)
    unless self.same_vahed? other
      raise ArgumentError.new "Operands to + must have same units!" +
                              " '#{self.vstr}' and '#{other.vstr}'"
    end

    value = @value + other.value
    e0 = @epsilon[0] + other.e[0]
    e1 = @epsilon[1] + other.e[1]

    self.class.new value, {e0, e1}, @vahed
  end

  def -(other : self)
    self + (other * -1)
  end

  # TODO: error handling code is **WRONG**!!!
  def *(other : Number)
    value = @value * other
    e0 = @epsilon[0] * other.abs
    e1 = @epsilon[1] * other.abs
    self.class.new value, {e0, e1}, @vahed
  end

  def *(other : self)
    value = @value * other.value

    e0 = other.value.abs * @epsilon[0] + @value.abs * other.e[0]
    e1 = other.value.abs * @epsilon[1] + @value.abs * other.e[1]

    vahed = @vahed + other.vahed

    self.class.new value, {e0, e1}, vahed
  end

  def /(other : Number)
    value = @value / other
    e0 = @epsilon[0] / other.abs
    e1 = @epsilon[1] / other.abs
    self.class.new value, {e0, e1}, @vahed
  end

  def /(other : self)
    value = @value / other.value

    e0 = other.value.abs * @epsilon[0] + @value.abs * other.e[0]
    e1 = other.value.abs * @epsilon[1] + @value.abs * other.e[1]

    vahed = @vahed + other.vahed.map { |v| JomleVahed.new v.prefix, v.vahed, -v.power }

    self.class.new value, {e0, e1}, vahed
  end

  def **(exp : Int32)
    value = @value ** exp
    e0 = @epsilon[0] * exp
    e1 = @epsilon[1] * exp
    vahed = @vahed.map { |v| JomleVahed.new v.prefix, v.vahed, v.power*exp }

    self.class.new value, {e0, e1}, vahed
  end
end
