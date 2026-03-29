let $customers := doc("CLASSICMODELS_BD/Customers.xml")/customers/customer
for $c in $customers
where $c/creditLimit != "NULL"
  and number($c/creditLimit) >= 1160
  and number($c/creditLimit) <= 1165
return $c/customerName/text()
