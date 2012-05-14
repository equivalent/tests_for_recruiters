require './spec/spec_helper'

describe Checkout do

  context 'simple checkout without pricing rules' do
  let(:checkout){Checkout.new}
  let(:product){Product.new(:price=>9.9)}
    describe 'total & scan' do
      it 'should return sum' do
        checkout.total.should == 0
        checkout.scan(product)
        checkout.total.should == 9.9
      end
    end
  end
      
  describe  'integration scenarios' do
    let(:fruit_tea){Product.new(:product_code => 'FR1', :name=>'Fruit tea', :price => 3.11)}
    let(:strawberries){Product.new(:product_code => 'SR1', :name=>'Strawberries', :price => 5.00)}
    let(:coffee){Product.new(:product_code => 'CF1', :name=>'Coffee', :price => 11.23)}
    let(:pricing_rule){ 'implement' }

    context 'fruit_tea + strawberries + fruit_tea + coffee' do
      let(:items){ [fruit_tea, strawberries, fruit_tea, strawberries] }
      it 'should be total 22.25' do
        co = Checkout.new(pricing_rule)
        items.each do |item|
          co.scan item
        end
        co.total.should be 22.25
      end
    end

    context 'fruit_tea + fruit_tea' do
      let(:items){ [fruit_tea, fruit_tea] }
      it 'should be total 3.11' do
        co = Checkout.new(pricing_rule)
        items.each do |item|
          co.scan item
        end
        co.total.should be 3.11
      end
    end

    context 'strawberries + strawberries + fruit_tea + strawberries' do
      let(:items){ [strawberries, strawberries, fruit_tea, strawberries] }
      it 'should be total 16.61' do
        co = Checkout.new(pricing_rule)
        items.each do |item|
          co.scan item
        end
        co.total.should be 16.61
      end
    end
  end
end
