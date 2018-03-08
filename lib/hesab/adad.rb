require_relative './unit.rb'

class Adad

  # Initializing an instance of Adad
  #
  # === Attributes
  # +value+:: value of the new Adad
  # +epsilon+:: absolute uncertainty(-ies_ of the Adad) (optional)
  # +units_and_powers+:: pairs of units and their powers in succession
  #
  # ==== Examples
  # > H = Adad.new 67.48, [0.98], :km, 1, :Mpc, -1, :s, -1
  # => #<Adad:...>
  def initialize(value, epsilon=nil, *units_and_powers)
    if epsilon.is_a?(Symbol)
      return initialize(value, nil, epsilon, *units_and_powers)
    end

    @A = { v: value, u: { L: [], M: [], T: [], Th: [], N: [] }, e: [0.0, 0.0]}
    @symb = nil

    unless epsilon.nil?
      case epsilon.length
      when 0
        @A[:e] = [0, 0]
      when 1
        @A[:e] = [epsilon[0], epsilon[0]]
      when 2
        @A[:e] = epsilon
      else
        raise ArgumentError, "Don't know how to handle uncertainties"
      end
    end

    units_and_powers.each_slice(2) do |unit, pow|
      prfx, symb = Unit::check_for_prfx unit

      Unit::Dim.each do |dim|
        next unless Unit::UNITS[dim].key? symb
        @A[:u][dim] << Unit::gen_unit(prfx, symb, pow)
      end

      Unit::DERIVED[symb].each do |d,us|
        us.each do |u|
          @A[:u][d] << Unit::gen_unit(u[:prfx], u[:symb], u[:pow] * pow)
        end
      end if Unit::DERIVED.key? symb
    end
  end


  # Returns the value of the number
  def value
    @A[:v]
  end

  def v
    self.value()
  end


  # Returns the unit of the number
  def unit
    unit = "["
    @A[:u].each do |_,us|
      us.each do |u|
        unit += " #{u[:prfx] unless u[:prfx] == :one}#{u[:symb]}"
        unit += "^#{u[:pow]}" unless u[:pow] == 1
      end
    end
    unit += " ]"
  end

  def u
    self.unit()
  end


  # Returns uncertainties
  def e
    @A[:e]
  end


  # Cloning
  def clone
    adad = Adad.new @A[:v]
    adad.instance_variable_get(:@A)[:u] = Marshal.load(Marshal.dump(@A[:u]))
    adad.instance_variable_get(:@A)[:e] = Marshal.load(Marshal.dump(@A[:e]))
    return adad
  end


  # Check if a given unit have the same dimension of the self unit
  #
  # === Attributes
  # +adad+:: a given Adad
  def same_dimension?(adad)
    def pows(us)
      return us.map { |u| u[:pow] }.reduce(:+) || 0
    end

    us = adad.instance_variable_get(:@A)[:u]
    Unit::Dim.each { |d| return false unless pows(@A[:u][d]) == pows(us[d]) }
  end


  # Addition
  #
  # === Attributes
  # +s+:: a given summand of type Adad
  def +(s, mod=1)
    raise ArgumentError unless s.is_a? Adad
    raise ArgumentError unless self.same_dimension? s

    adad, a = _clone_self
    s_a = s.instance_variable_get(:@A)
    conv_fact = _factor_to_SI(s) / _factor_to_SI(self)

    a[:v] += s_a[:v] * conv_fact * mod
    [0,1].each { |i| a[:e][i] += conv_fact * s_a[:e][i] }

    return adad
  end

  # Subtracting by an Adad
  #
  # === Attributes
  # +s+:: a given subtrahend of type Adad
  def -(s)
    self.+(s, -1)
  end


  # Multiplying by an Adad or a Numeric value
  #
  # === Attributes
  # +m+:: multiplicand of type Adad or Numeric
  #
  # TODO: use coerce to be able to run scalar * Adad
  def *(m, mod=1)
    adad, a = _clone_self

    if m.is_a? (Numeric)
      a[:v] *= m**mod
      a[:e] = a[:e].collect { |e| e*m**mod }
    elsif m.is_a? (Adad)
      m_A = m.instance_variable_get(:@A)

      [0,1].each { |i| a[:e][i] = m_A[:v] * a[:e][i] + a[:v] * m_A[:e][i] }

      a[:v] *= m_A[:v]**mod

      m_A[:u].each do |d, m_us|
        m_us.each do |m_u|
          a[:u][d] << Unit::gen_unit(m_u[:prfx], m_u[:symb], m_u[:pow] * mod)
        end
      end
    end

    return adad
  end


  # Division by an Adad or a Numeric value
  #
  # === Attributes
  # +d+:: divisor of type Adad or Numeric
  def /(d)
    self.*(d, -1)
  end


  # Exponentiation by a scalar (of type Numeric)
  #
  # === Attributes
  # +ex+:: exponent of type Numeric
  def **(ex)
    raise ArgumentError unless ex.is_a? (Numeric)

    adad, a = _clone_self

    a[:v] **= ex
    a[:u].each { |_, us| us.each { |u| u[:pow] *= ex } }
    [0,1].each { |i| a[:e][i] *= ex }

    return adad
  end


  # Simplify units by canceling similar dimensions (if present)
  def simplify!
    Unit::Dim.each do |dim|
      next if @A[:u][dim].length <= 1

      sum_pows = @A[:u][dim].map { |u| u[:pow] }.reduce(:+)
      @A[:u][dim].each { |u| @A[:v] *= Unit::conv_fact(u) }

      if sum_pows == 0
        @A[:u][dim] = []
      else
        def_u = Unit::UNITS[dim][:default]
        @A[:u][dim] = [Unit::gen_unit(def_u[:prfx], def_u[:symb], sum_pows)]
        @A[:v] /= Unit::conv_fact(def_u)
      end
    end

    return self
  end


  # Returns a converted Adad with a new given unit
  #
  # === Attributes
  # +units_and_powers+:: pairs of units and their powers in succession
  # TODO: Check if dimensions match
  def to(*units_and_powers)

    adad, a = _clone_self

    Unit::Dim.each do |dim|
      a[:u][dim].each { |u| a[:v] *= Unit::conv_fact(u) }
      a[:u][dim] = []
    end

    units_and_powers.each_slice(2) do |unit, pow|
      prfx, symb = Unit::check_for_prfx unit

      Unit::Dim.each do |dim|
        next unless Unit::UNITS[dim].key? symb

        u = Unit::gen_unit(prfx, symb, pow)

        a[:v] /= Unit::conv_fact(u)
        a[:u][dim] << u
      end

      Unit::DERIVED[symb].each do |d, us|
        us.each do |u|
          a[:v] /= Unit::conv_fact(u)
          a[:u][d] << Unit::gen_unit(u[:prfx], u[:symb], u[:pow] * pow)
        end
      end if Unit::DERIVED.key? symb
    end

    return adad
  end

  # Generating a symbol version of the adad
  def symb
    return @symb unless @symb.nil?

    @symb = Formul.new self
    @symb
  end

  private

  # Returns a cloned version of self alongside of pointer to the @A of the clone
  def _clone_self
    adad = self.clone
    return adad, adad.instance_variable_get(:@A)
  end

  # Returns the SI conversion factor (only a Numeric)
  #
  # === Attributes
  # +adad+:: a given adad
  def _factor_to_SI(adad)
    adad.instance_variable_get(:@A)[:u].map { |_,us|
      us.map { |u| Unit::conv_fact(u) }
    }.flatten.reduce :*
  end


end
