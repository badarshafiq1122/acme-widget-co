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

def run_test_case(basket, items, expected_total, description)
  items.each { |code| basket.add(code) }
  actual_total = basket.total
  result = (actual_total - expected_total).abs < 0.01 ? "Pass" : "Fail"
  puts "#{result} #{description}"
  puts "  Items: #{items.join(', ')}"
  puts "  Expected: $#{expected_total}"
  puts "  Actual: $#{actual_total}"
  puts
end

# Test Case 1: Basic order with no special offers
basket = Basket.new(catalog, delivery_rules, offers)
run_test_case(basket, ['B01', 'G01'], 37.85, "Basic order with no special offers")

# Test Case 2: Order with special offer (buy one get one half price)
basket = Basket.new(catalog, delivery_rules, offers)
run_test_case(basket, ['R01', 'R01'], 54.37, "Order with special offer (buy one get one half price)")

# Test Case 3: Mixed order with and without special offers
basket = Basket.new(catalog, delivery_rules, offers)
run_test_case(basket, ['R01', 'G01'], 60.85, "Mixed order with and without special offers")

# Test Case 4: Large order with multiple special offers and free delivery
basket = Basket.new(catalog, delivery_rules, offers)
run_test_case(basket, ['B01', 'B01', 'R01', 'R01', 'R01'], 98.27, "Large order with multiple special offers and free delivery")

# Test Case 5: Edge case - single item
basket = Basket.new(catalog, delivery_rules, offers)
run_test_case(basket, ['R01'], 37.90, "Edge case - single item")
