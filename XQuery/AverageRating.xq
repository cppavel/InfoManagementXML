(:this file contains two queries getAverageRating and sortProducts by average 
  rating:)
declare function local:getAverageRating($productId as xs:string){
  let $commentIds:= <commentIds>{for $p in doc("../XML/Product.xml")/
    databaseProduct/Product where $productId = $p/@id return $p/
      Product.comments/Comment}</commentIds>
  
  let $ratings:= <ratings>{
  for $commentId in $commentIds/Comment/@refid
    for $c in doc("../XML/Comment.xml")/databaseComment/Comment
      where $commentId = $c/@id return <entry>{$c/@rating}</entry>}</ratings>
      
  let $numericalRatings:= $ratings/entry/xs:double(@rating)
      
  return avg($numericalRatings)
};

declare function local:getProduct($productId as xs:string){
  for $p in doc("../XML/Product.xml")/
    databaseProduct/Product where $productId = $p/@id return $p
};

declare function local:sortProductsByAverageRating($shopId as xs:string,$order 
  as xs:string){
  let $shop:= <shop>{for $sh in doc ("../XML/Shop.xml")/databaseShop/Shop
  where $shopId = $sh/@id return $sh}</shop>
  
  let $results:= for $p in $shop/Shop/Shop.products/Product
      return <entry>{local:getProduct($p/@refid)/Product.name,
        <avgRating>{local:getAverageRating($p/@refid)}</avgRating>}</entry>
  
  let $sortedList:= if($order = "asc") then 
    for $rs in $results order by $rs/avgRating 	ascending return $rs
    else if($order = "dsc") then 
      for $rs in $results order by $rs/avgRating 	descending return $rs
    
  return $sortedList
};

<results>{
<justAvgRating>{local:getAverageRating("p228")}</justAvgRating>,
<listDescending>{local:sortProductsByAverageRating("s1","dsc")}</listDescending>,
<listAscending>{local:sortProductsByAverageRating("s1","asc")}</listAscending>}
</results>