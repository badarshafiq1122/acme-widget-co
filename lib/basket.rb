# This class manages the collection of products, applies special offers,
# and calculates the total price including delivery costs.
class Basket
  def initialize(catalog, delivery_rules, offers)
    @catalog = catalog
    @delivery_rules = delivery_rules.sort_by { |rule| -rule[:threshold] }
    @offers = offers
    @items = []
  end

  def add(product_code)
    product = @catalog[product_code]
    raise ArgumentError, "Product not found: #{product_code}" unless product
    @items << product
  end

  def total
    subtotal = calculate_subtotal
    (subtotal + calculate_delivery_cost(subtotal)).floor(2)
  end

  private

  def calculate_subtotal
    @items.sum(&:price)
  end

  def calculate_delivery_cost(subtotal)
    # Find the first rule where the threshold is less than or equal to the subtotal
    rule = @delivery_rules.find { |rule| rule[:threshold] <= subtotal }
    rule[:cost]
  end
end
