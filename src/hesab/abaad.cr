enum Abaad
  Length,
  Mass,
  Time,
  I,    # Electrical Current
Theta,  # Absolute Temperature
N,      # Amount of Substance
J       # Luminous Intensity

  def self.from_sym(sym : Symbol)
    SYM[sym]
  end
end

private SYM = {
  :L  => Abaad::Length,
  :M  => Abaad::Mass,
  :T  => Abaad::Time,
  :I  => Abaad::I,
  :N  => Abaad::N,
  :J  => Abaad::J,
  :Th => Abaad::Theta,
}
