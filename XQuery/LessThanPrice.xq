declare function local:getCheaperThan($priceLimit){
  for $p in doc("Product.xml")/databaseProduct/Product
  where $p/Product.price<30.00
  order by $p/Product.price ascending
  return <result>{$p/Product.name, $p/Product.price}</result>
};

local:getCheaperThan(30.00)