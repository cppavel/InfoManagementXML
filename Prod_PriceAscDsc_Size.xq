(:this file contains two queries sortProductsByPrice, listProductOfSpecifiedSize:)

declare function local:sortProductsByPrice($shopId as xs:string, $order as xs:string) {
    for $shs in doc("../XML/Shop.xml")/databaseShop
        where $shopId = ($shs/@id)
            if ($order == "asc")
                for $prods in doc("../XML/Shop.xml")/databaseShop/Shop/Shop.product order by $prods/price ascending 
                    return $prods
            else if ($order == "dsc")
                for $prods in doc("../XML/Shop.xml")/databaseShop/Shop/Shop.product order by $prods/price descending 
                    return $prods
    
};

declare function local:listProductOfSpecifiedSize($shopId as xs:string, $size as xs:string) {
    let $results:= for $shs in doc("../XML/Shop.xml")/databaseShop/Shop
        where $shopId = ($sh/@id) 
            for $p in doc("../XML/Shop.xml")/databaseShop/Shop/Shop.product
                where contains($p/@Product.size, size)
                    return $p
   
};

<results> {
<listDescending>{local:sortProductsByPrice("s1","dsc")}</listDescending>,
<listAscending>{local:sortProductsByPrice("s1","asc")}</listAscending>
<availableInSize>{local:listProductOfSpecifiedSize("s2", "M")}</availableInSize>
}
</results>