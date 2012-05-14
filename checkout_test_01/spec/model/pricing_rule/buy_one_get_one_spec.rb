require './spec/spec_helper'

describe PricingRule::BuyOneGetOne do
  let(:product1){Product.new(:product_code=>'aa', :price => 99.99)}
  let(:product2){ Product.new(:product_code=>'bb', :price => 11.11)}
   
  describe 'instance method "add"' do
    it 'should add item if the initalization ocured with that product code' do
      rule = PricingRule::BuyOneGetOne.new(product1)
      rule.add(product1)
      rule.items.include?(product1).should be_true
    end

    it 'should not add item if the initalization ocured without that product code' do
      rule = PricingRule::BuyOneGetOne.new(product1)
      rule.add(product2)
      rule.items.include?(product2).should be_false
    end
  end

  describe 'instance method "discount"' do
    context 'when I have 5 buy one get one free products,' do
      before do
        @rule = PricingRule::BuyOneGetOne.new(product1)
        5.times do
          @rule.add(product1)
        end
      end

      it  '2 should be free' do
        @rule.discount.should == (2 * product1.price)
      end
    end

    context 'when I have 1 buy one get one free products,' do
      before do
        @rule = PricingRule::BuyOneGetOne.new(product1)
        @rule.add(product1)
      end

      it  'I should not have any discount' do
        @rule.discount.should == 0.0
      end
    end



  end
end
