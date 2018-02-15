require_relative './unit.rb'

class Adad

  # Initializing an instance of Adad
  #
  # === Attributes
  # +value+:: value of the new Adad
  # +epsilon+:: absolute uncertainty(-ies_ of the Adad) (optional)
  # +units+:: pairs of units and their powers in succession
  #
  # ==== Examples
  # > H = Adad.new 67.48, [0.98], :km, 1, :Mpc, -1, :s, -1
  # => #<Adad:...>
  def initialize(value, epsilon=nil, *units_and_powers)
    if epsilon.is_a?(Symbol)
      return initialize(value, nil, epsilon, *units_and_powers)
    end

    @A = { v: value, u: { L: [], M: [], T: [], Th: [], N: [] }, e: [0.0, 0.0]}

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
end
