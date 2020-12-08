declare function local:getTotalCostOfWishlist($customerId as xs:string, $add as xs:string) {
    for $w in doc("../XML/Customer.xml")/databaseCustomer
        where $customerId = ($w/@id)

     for $pri in ("../XML/Customer.xml")/databaseCustomer/Customer/Customer.Wishlist 
        where $pri/price
            return $pri

    let $add:= sum($pri)
    return $add
};

