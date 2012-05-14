class Checkout

  attr_reader :total
  def initialize(pricing_rules={})
    @total = 0.0


  end
  
  def scan(item)
    @total += item.price.to_f
  end

end
