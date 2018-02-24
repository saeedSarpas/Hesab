class Formul

  # Initializing an instance of Formul
  #
  # === Attributes
  # +f+:: a given instance of Adad, Bordar, Formul or Hash
  #
  # ==== Examples
  # formul = Formul.new Adad.new(1.23, :km, 1, :s, -1)
  # => #<Formul:...>
  def initialize(f)
    raise ArgumentError unless [Adad, Bordar, Formul, Hash].any? { |c| f.is_a?(c) }

    @F = f
  end


  # Cloning
  def clone
    Formul.new Marshal.load(Marshal.dump(@F))
  end


  # Perform an operation (currently only addition, multiplication and division)
  #
  # === Attributes
  # +operand+:: a given operand of type Formul
  # +op+:: symbol of the operation
  def operate(operand, op)
    raise ArgumentError unless operand.is_a? Formul

    f = self.clone
    f.instance_variable_set(:@F,
      {op => [@F, operand.instance_variable_get(:@F)]})
    return f
  end


  # Addition
  #
  # === Attributes
  # +s+:: a given summand of type Formul
  def +(s)
    self.operate(s, :+) if s.is_a? Formul
  end


  # Multiplying by an Adad or a Numeric value
  #
  # === Attributes
  # +m+:: multiplicand of type Formul
  def *(m)
    self.operate(m, :*) if m.is_a? Formul
  end


  # Addition
  #
  # === Attributes
  # +d+:: a given divisor of type Formul
  def /(d)
    self.operate(d, :/) if d.is_a? Formul
  end


  # Exponentiation by a scalar (of type Numeric)
  #
  # === Attributes
  # +ex+:: exponent of type Numeric
  def **(ex)
    f = self.clone
    f.instance_variable_set(:@F, {:** => [@F, ex]})
    return f
  end
end
