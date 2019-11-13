require 'pry'

def consolidate_cart(cart)
  new_cart = {}
  cart.each do |element_hash|
  binding.pry
    element_name = element_hash.keys[0]
    element_stats = element_hash.values[0]

    if new_cart.has_key?(element_name)
      element_stats[:count] += 1
    else
      new_cart[element_name] = element_stats
      new_cart[element_name][:count] = 1
    end
  end
  new_cart
end


def apply_coupons(cart, coupons)
  coupons.each do |coupon|
    item = coupon[:item]
    item_coupon = "#{item} W/COUPON"
    
 if cart[item]
   if cart[item][:count] >= coupon[:num]
     if !cart[item_coupon]
    cart[item_coupon] = {price: coupon[:cost] / coupon[:num], clearance: cart[item][:clearance] , count: coupon[:num]}
    else
    cart[item_coupon][:count] += coupon[:num]
    end
    cart[item][:count] -= coupon[:num]
    end
  end
 end
 cart
end

def apply_clearance(cart)
    cart.each do |item, attribute|
    
    if attribute[:clearance] == true
       attribute[:price] = (attribute[:price] * 0.8).round(2)
     end
    end
  cart
end

def checkout(items, coupons)
  cart = consolidate_cart(items)
  cart1 = apply_coupons(cart, coupons)
  cart2 = apply_clearance(cart1)
  
  total = 0
  
  cart2.each do |name, price_hash|
    total += price_hash[:price] * price_hash[:count]
  end
  
  total > 100 ? total * 0.9 : total
  
end
