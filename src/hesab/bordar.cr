struct Bordar
  property length : Adad
  property direction : Array(Float64)

  def initialize(length : Adad | Number, @direction : Array(Float64))
    @length = length.is_a?(Adad) ? length : Adad.new length
  end

  def l
    @length
  end

  def d
    @direction
  end

  def *(other : Number | Adad)
    self.class.new @length * other, @direction
  end
end
