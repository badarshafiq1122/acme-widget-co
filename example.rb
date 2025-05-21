require_relative 'lib/basket'
require_relative 'lib/product'

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

# Create basket with no offers for now
basket = Basket.new(catalog, delivery_rules, [])

# Test delivery cost calculation
puts "Testing delivery cost calculation:"
puts "================================="

# Test case 1: Order under $50
basket = Basket.new(catalog, delivery_rules, [])
basket.add('B01')
basket.add('B01')
puts "Order under $50: $#{basket.total}"

# Test case 2: Order between $50 and $90
basket = Basket.new(catalog, delivery_rules, [])
basket.add('R01')
basket.add('G01')
puts "Order between $50 and $90: $#{basket.total}"

# Test case 3: Order over $90
basket = Basket.new(catalog, delivery_rules, [])
basket.add('R01')
basket.add('R01')
basket.add('G01')
puts "Order over $90: $#{basket.total}"
