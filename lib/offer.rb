# This class defines the interface that all offer types must implement.
class Offer
  def apply(items)
    items
  end
end

class BuyOneGetOneHalfPriceOffer < Offer
  def initialize(product_code)
    @product_code = product_code
  end

  def apply(items)
    matching_items = items.select { |item| item.code == @product_code }
    return items if matching_items.length < 2

    price = matching_items.first.price

    pairs = matching_items.length / 2
    remaining = matching_items.length % 2
    total_price = (pairs * (price + price * 0.5)) + (remaining * price)

    new_item = Product.new(
      code: @product_code,
      name: matching_items.first.name,
      price: total_price,
    )

    items.reject { |item| item.code == @product_code } + [new_item]
  end
end
