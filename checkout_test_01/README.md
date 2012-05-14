
    Product code       Name        Price
    FR1            Fruit tea       £ 3.11
    SR1          strawberries      £ 5.00
    CF1              Coffee        £11.23


*  implement "buy one get one free" on fruit tea
*  impement  "if you buy more than three strawberies price will drop to
   4.50"


## interface that exist

    co = Checkout.new(pricing_rules)
    co.scan(item)
    co.scan(item)
    Price = co.total


## Test Data provided

    Basket: FR1, FR1
    Total price expected: £3.11

    Basket: SR1, SR1, FR1, SR1
    Total price expected: £16.61

    Basket: FR1, SR1, FR1, CF1
    Total price expected: £22.25

last integration test is wrong !!! 
    
    3.11 + 5 + 11.23 = 19.34 

total price expected should be 19.34


#solution
  
    #irb
    Dir['./model/**/*.rb'].each {|file| require file }
    fruit_tea = Product.new(:product_code => 'FR1', :name=>'Fruit tea', :price => 3.11)
    strawberrie = Product.new(:product_code => 'SR1', :name=>'Strawberrie', :price => 5.00)
    coffee = Product.new(:product_code => 'CF1', :name=>'Coffee', :price => 11.23)

    
    checkout = Checkout.new([PricingRule::BuyOneGetOne.new(fruit_tea), PricingRule::AmountDiscount.new(strawberrie, 3, 4.50)]) 
    checkout.scan fruit_tea
    checkout.scan fruit_tea
    checkout.scan strawberrie
    checkout.scan strawberrie
    checkout.scan strawberrie
    checkout.scan coffee
    checkout.total



 


