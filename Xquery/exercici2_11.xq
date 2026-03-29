for $c in doc("CLASSICMODELS_BD/Payments.xml")//check
where $c/customer/@customerNumber = "103"
return $c/@number