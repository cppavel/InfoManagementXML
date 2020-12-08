declare function local:getPastOrders($orderId as xs:string, $sort as xs:string) {
    for $pa in doc("../XML/Order.xml")/databaseOrder/Order
    where $orderId = $pa/@id return $pa

    let &sortByDate:= if($sort = )
};
