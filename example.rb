require_relative 'lib/basket'
require_relative 'lib/product'
require_relative 'lib/offer'

# Create product catalog
catalog = {
  'R01' => Product.new(code: 'R01', name: 'Red Widget', price: 32.95),
  'G01' => Product.new(code: 'G01', name: 'Green Widget', price: 24.95),
  'B01' => Product.new(code: 'B01', name: 'Blue Widget', price: 7.95)
}

# Define delivery rules
delivery_rules = [
  { threshold: 90, cost: 0 },    # Free delivery for orders >= $90
  { threshold: 50, cost: 2.95 }, # $2.95 delivery for orders >= $50
  { threshold: 0, cost: 4.95 }   # $4.95 delivery for all other orders
]

# Create special offer
offers = [BuyOneGetOneHalfPriceOffer.new('R01')]

puts "Testing Acme Widget Co Sales System"
puts "=================================="
puts

# Test case 1: Basic order with no special offers
basket = Basket.new(catalog, delivery_rules, offers)
basket.add('B01')
basket.add('G01')
puts "Basic order (B01, G01): $#{basket.total}"

# Test case 2: Order with special offer (buy one get one half price)
basket = Basket.new(catalog, delivery_rules, offers)
basket.add('R01')
basket.add('R01')
puts "Order with special offer (R01, R01): $#{basket.total}"

# Test case 3: Mixed order with and without special offers
basket = Basket.new(catalog, delivery_rules, offers)
basket.add('R01')
basket.add('G01')
puts "Mixed order (R01, G01): $#{basket.total}"

# Test case 4: Large order with multiple special offers
basket = Basket.new(catalog, delivery_rules, offers)
basket.add('B01')
basket.add('B01')
basket.add('R01')
basket.add('R01')
basket.add('R01')
puts "Large order with multiple offers: $#{basket.total}" 
