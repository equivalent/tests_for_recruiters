module PricingRule 
  class BuyOneGetOne
    attr_reader :items, :product_code
    def initialize(product)
      raise 'argument should by kind of Product' unless product.is_a?(Product)
      @product_code = product.product_code  #should be product id from db
      @product_price = product.price
      @items = []
    end

    def add(item)
      @items << item if (product_code == item.product_code)
    end

    def discount
      ((@items.count / 2) * @product_price).to_f
    end
  end
end
