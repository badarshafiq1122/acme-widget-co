# This class enforces data validation and provides an immutable data structure.
class Product
  attr_reader :code, :name, :price

  def initialize(code:, name:, price:)
    validate_attributes(code, name, price)
    @code = code
    @name = name
    @price = price
  end

  private

  def validate_attributes(code, name, price)
    raise ArgumentError, "Code cannot be empty" if code.to_s.strip.empty?
    raise ArgumentError, "Name cannot be empty" if name.to_s.strip.empty?
    raise ArgumentError, "Price must be positive" if price.to_f <= 0
  end
end
