let $customerNumbers := ("103", "112")
for $c in doc("CLASSICMODELS_BD/Payments.xml")//check
where $c/customer/@customerNumber = $customerNumbers
return $c/@number