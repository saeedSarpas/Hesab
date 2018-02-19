require_relative './adad.rb'


class Bordar

  # Constructing a Border::Generate instance
  #
  # ==== Attributes
  # +length+:: length of the vector (Adad or scalar)
  # +direction+:: direction of the vector (var-length array of scalars)
  #
  # ==== Examples
  # > b = Bordar.new 67.48, [0.98], :km, 1, :Mpc, -1, :s, -1
  # => #<Adad::Generate:...>
  def initialize(length, direction)
    @B = {
      l: length.is_a?(Adad) ? length : Adad.new(length),
      d: direction.is_a?(Numeric) ? [direction] : direction
    }
    @symb = nil
  end


  # Length of the vector (Adad)
  def length
    @B[:l]
  end

  def l
    self.length()
  end


  # Direction of the vector (Array)
  def direction
    @B[:d]
  end

  def d
    self.direction()
  end


  def clone
    l, d = @B[:l].clone, @B[:d].clone
    Bordar.new l, d
  end


  # Multiplying by a scalar or an Adad
  #
  # === Attributes
  # +m+:: multiplicand of type Adad or Numeric
  def *(m)
    raise ArgumentError unless m.is_a?(Numeric) or m.is_a?(Adad)

    bordar = self.clone
    bordar.instance_variable_get(:@B)[:l] *= m

    return bordar
  end

  # Generating a symbol version of the bordar
  def symb
    return @symb unless @symb.nil?

    @symb = Formul.new self
    @symb
  end
end
