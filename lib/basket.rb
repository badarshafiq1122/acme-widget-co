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
    return 0.0 if @items.empty?

    discounted_items = apply_offers
    subtotal = calculate_subtotal(discounted_items)

    (subtotal + calculate_delivery_cost(subtotal)).floor(2)
  end

  private

  def apply_offers
    result = @items
    @offers.each do |offer|
      result = offer.apply(result)
    end
    result
  end

  def calculate_subtotal(items)
    items.sum(&:price)
  end

  def calculate_delivery_cost(subtotal)
    # Find the first rule where the threshold is less than or equal to the subtotal
    rule = @delivery_rules.find { |rule| rule[:threshold] <= subtotal }
    raise "No delivery rule found for subtotal: #{subtotal}" unless rule
    rule[:cost]
  end
end
