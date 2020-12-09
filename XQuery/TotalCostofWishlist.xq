declare function local:getTotalCostOfWishlist($customerId as xs:string) {
  
   let $products:= for $w in doc("../XML/Customer.xml")/databaseCustomer/Customer
        where $customerId = $w/@id return $w/Customer.Wishlist/Product/@refid
        
   let $prices:= for $id in $products
                     for $p in doc("../XML/Product.xml")/databaseProduct/Product
                         where $id = $p/@id 
                                 return xs:double($p/Product.price/string())
           

   return sum($prices)
};

local:getTotalCostOfWishlist("cs1")

