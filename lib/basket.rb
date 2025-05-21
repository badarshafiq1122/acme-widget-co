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
    @items.sum(&:price)
  end
end
