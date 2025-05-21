# Acme Widget Co Sales System

A simple and efficient sales system for Acme Widget Co, handling product catalog, delivery charges, and special offers.

## Features

- Product catalog with three widgets (Red, Green, Blue)
- Special offer: "Buy one red widget, get the second half price"
- Dynamic delivery cost rules based on basket total:
  - Free delivery for orders >= $90
  - $2.95 delivery for orders >= $50
  - $4.95 delivery for all other orders

## Project Structure

```
.
├── lib/
│   ├── basket.rb      # Shopping basket implementation
│   ├── product.rb     # Product class with validation
│   └── offer.rb       # Special offers implementation
├── example.rb         # Usage examples and test cases
└── README.md         # This file
```

## Usage

Run the example file to see the system in action:

```bash
ruby example.rb
```

This will demonstrate various scenarios including:
- Basic orders
- Special offers
- Delivery cost calculations
- Edge cases

## Design Decisions

1. **Product Class**
   - Enforces data validation
   - Ensures consistent product structure
   - Prevents invalid data entry
   - Simple and focused validation rules

2. **Basket Class**
   - Handles product addition and total calculation
   - Applies special offers before delivery charges
   - Uses sorted delivery rules for consistent behavior
   - Clear separation of concerns

3. **Offer System**
   - Flexible design for adding new offers
   - Clean separation of offer logic
   - Easy to extend with new offer types
   - Strategy pattern implementation

## Implementation Details

### Product
- Immutable data structure
- Validates product attributes
- Ensures price is positive
- Simple and focused validation

### Basket
- Manages product collection
- Applies special offers
- Calculates delivery costs based on order total
- Computes final price

### Offer
- Implements special offer logic
- Currently supports Buy One Get One Half Price
- Extensible for additional offer types

## Assumptions

1. Product codes are case-sensitive
2. The basket can handle multiple quantities of the same product
3. Special offers are applied before delivery charges
4. Delivery charges are calculated based on the final basket total after offers
5. The system is designed to be extensible for future offers and delivery rules

## Example Output

Running `example.rb` will show test cases with:
- Input items
- Expected total
- Actual total
- Pass/fail indicators

## Setup

1. Install dependencies:
```