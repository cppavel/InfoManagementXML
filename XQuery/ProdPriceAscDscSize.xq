(:this file contains two queries sortProductsByPrice, listProductOfSpecifiedSize:)

declare function local:sortProductsByPrice($shopId as xs:string, $order as xs:string) {
    let $productIds:= for $shs in doc("../XML/Shop.xml")/databaseShop/Shop
        where $shopId = $shs/@id return $shs/Shop.products/Product/@refid
    
    let $products:= for $productId in $productIds
          for $p in doc ("../XML/Product.xml")/databaseProduct/Product
            where $productId = $p/@id return $p
            
    let $sortedProducts:= if($order = "asc") then 
    for $p in $products order by $p/Product.price 	ascending return $p
    else if($order = "dsc") then 
      for $p in $products order by $p/Product.price 	descending return $p
   
    return $sortedProducts
           
    
};

declare function local:listProductOfSpecifiedSize($shopId as xs:string, $size as xs:string) {
    let $productIds:= for $shs in doc("../XML/Shop.xml")/databaseShop/Shop
        where $shopId = $shs/@id return $shs/Shop.products/Product/@refid
    
    let $products:= for $productId in $productIds
          for $p in doc ("../XML/Product.xml")/databaseProduct/Product
            where $productId = $p/@id return $p
    let $results:= for $p in $products
                where exists(index-of($p/Product.size, $size)) return $p 
            
                    
    return $results
   
};

<results> 
{
<listDescending>{local:sortProductsByPrice("s1","dsc")}</listDescending>,
<listAscending>{local:sortProductsByPrice("s1","asc")}</listAscending>,
<availableInSize>{local:listProductOfSpecifiedSize("s2", "M")}</availableInSize>
}
</results>
