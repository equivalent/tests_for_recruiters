class Checkout

  def initialize(pricing_rules=[])
    @pricing_rules = pricing_rules
    @total = 0.0
  end
  
  def scan(item)
    @total += item.price.to_f
    @pricing_rules.each do |rule|
      rule.add item
    end
  end

  def total
    total_price = @total
    @pricing_rules.each do |rule|
      total_price -= rule.discount
    end
    return total_price
  end

end
