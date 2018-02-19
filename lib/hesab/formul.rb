class Formul

  # Initializing an instance of Formul
  #
  # === Attributes
  # +input+:: a given instance of Adad or Bordar
  #
  # ==== Examples
  # formul = Formul.new Adad.new(1.23, :km, 1, :s, -1)
  # => #<Formul:...>
  def initialize(input)
    raise ArgumentError unless input.is_a?(Adad) or input.is_a?(Bordar)

    @F = input
  end
end
