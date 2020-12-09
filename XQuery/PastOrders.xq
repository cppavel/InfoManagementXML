declare function local:parseDate($date as xs:string){
  let $tokenized:= tokenize($date,"\.")
  
  return xs:integer($tokenized[3]||$tokenized[2]||$tokenized[1])
};

declare function local:getPastOrders($customerId as xs:string, $sort as xs:string) {
  
    let $orders:= for $o in doc("../XML/Order.xml")/databaseOrder/Order
              where $o/Order.customer/Customer/@refid = $customerId return 
              <entity>
                {$o,<parsedDate>{local:parseDate($o/Order.dateOrdered)}</parsedDate>}
              </entity>
              
              
    let $sortedOrders:= if($sort = "asc") then 
    for $o in $orders order by $o/parsedDate 	ascending return $o
    else if($sort = "dsc") then 
      for $o in $orders order by $o/parsedDate 	descending return $o  
           
    return $sortedOrders

};


<results> 
{
<parsedDate>{local:parseDate("01.12.20")}</parsedDate>,
<listDescending>{local:getPastOrders("cs2","dsc")}</listDescending>,
<listAscending>{local:getPastOrders("cs2","asc")}</listAscending>
}
</results>


