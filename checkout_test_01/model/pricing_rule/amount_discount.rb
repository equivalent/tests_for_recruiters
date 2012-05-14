module PricingRule
  class AmountDiscount
    attr_reader :product_code, :items, :initial_price, :drop_price, :min_amount
    def initialize(product, min_amount, drop_price )
      raise ('First argument must be kind of product') unless product.is_a?(Product)
      @items = []
      @drop_price = drop_price
      @min_amount = min_amount
      @product_code = product.product_code
      @initial_price = product.price
    end

    def add(item)
      @items << item if (self.product_code == item.product_code)
    end

    def discount
      total_discount = 0.0

      if (items.count / min_amount) > 0
        items.each do |item|
          total_discount += initial_price - drop_price
        end
      end

      return total_discount
    end
  end
end
