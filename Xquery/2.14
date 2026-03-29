let $names := ("King", "Schmitt")
let $custNums := doc("CLASSICMODELS_BD/Customers.xml")//customer[contact/contactLastName = $names]/@customerNumber
for $c in doc("CLASSICMODELS_BD/Payments.xml")//check
where $c/customer/@customerNumber = $custNums
order by number($c/amount) descending
return $c/amount