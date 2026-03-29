let $custNum := doc("CLASSICMODELS_BD/Customers.xml")//customer[customerName = "Atelier graphique"]/@customerNumber
for $c in doc("CLASSICMODELS_BD/Payments.xml")//check
where $c/customer/@customerNumber = $custNum
return $c/@number