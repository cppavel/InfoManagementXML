declare function local:getAllCustomers(){
  for $c in doc("Customer.xml")/databaseCustomer/Customer
  order by $c/User.fullname descending
  return <result>{$c/User.fullname}</result>
};

local:getAllCustomers()