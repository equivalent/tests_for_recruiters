require './spec/spec_helper'

describe PricingRule::AmountDiscount do
  let(:product1){Product.new(:product_code=>'aa', :price => 99.99)}
  let(:product2){ Product.new(:product_code=>'bb', :price => 11.11)}


  describe 'initialization' do
    context 'when first argument isn\'t product' do
      it 'should raise error' do
        lambda{ PricingRule::AmountDiscount.new('wrong argument', 12, 10)}.should raise_error('First argument must be kind of product')
      end
    end
    it 'should set @drop_price @min_amount, @product_code' do
      rule = PricingRule::AmountDiscount.new(product1, 3, 10.10 )
      rule.instance_variable_get('@min_amount').should  == 3
      rule.instance_variable_get('@drop_price').should  == 10.10
      rule.instance_variable_get('@product_code').should  == product1.product_code
    end
  end
   
  describe 'instance method "add"' do
    it 'should add item if the initalization ocured with that product code' do
      rule = PricingRule::AmountDiscount.new(product1,1,1)
      rule.add(product1)
      rule.items.include?(product1).should be_true
    end

    it 'should not add item if the initalization ocured without that product code' do
      rule = PricingRule::AmountDiscount.new(product1,2,2)
      rule.add(product2)
      rule.items.include?(product2).should be_false
    end
  end

  describe 'instance method "discount"' do
    context 'when minimal amount discount is 3' do
      before :each do
        @rule = PricingRule::AmountDiscount.new(product1,3,4.09)
      end

      context 'and  I buy 5  amount_discount products,' do
        before do
          5.times do
            @rule.add(product1)
          end
        end
        it  'price of each product should drop to 4.09' do
          @rule.discount.should == (5 * ( product1.price - 4.09 ))
        end
      end

      context 'and I buy only 2 amount_disconut products' do
        before do
          2.times do
            @rule.add(product1)
          end
        end
        it  'I should not have any discount' do
          @rule.discount.should == 0.0
        end
      end

      context 'and I buy 3 amount_discount products' do
        before do
          3.times do
            @rule.add(product1)
          end
        end
        it  'I should not have any discount' do
          @rule.discount.should == (3 * ( product1.price - 4.09))
        end
      end
    end
  end
end
