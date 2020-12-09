declare function local:getCheaperThan($priceLimit){
  for $p in doc("../XML/Product.xml")/databaseProduct/Product
  where $p/Product.price<$priceLimit
  order by $p/Product.price ascending
  return <result>{$p/Product.name, $p/Product.price}</result>
};

local:getCheaperThan(30.00)
