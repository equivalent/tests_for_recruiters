class Product
  attr_reader :product_code, :name, :price
  def initialize(product_hash)
    @product_code = product_hash[:product_code]
    @name = product_hash[:name]
    @price = product_hash[:price]
  end
end
