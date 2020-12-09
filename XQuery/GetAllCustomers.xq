declare function local:getAllCustomers($SellerId as xs:string){
  let $customerIds:= for $o in doc("../XML/Order.xml")/databaseOrder/Order
  where $o/Order.seller/Seller/@refid = $SellerId return $o/Order.customer/Customer/@refid
  
  let $result:=for $csId in distinct-values($customerIds)
    for $cs in doc("../XML/Customer.xml")/databaseCustomer/Customer
      where $cs/@id = $csId return $cs
      
  return $result
  
};

local:getAllCustomers("sl1")
