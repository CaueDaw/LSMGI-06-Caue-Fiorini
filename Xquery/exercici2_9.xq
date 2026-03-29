let $nl := "&#10;"
return concat(
  "Número d'empleats: ", count(doc("CLASSICMODELS_BD/Employees.xml")//employee), $nl,
  "Número de clients: ", count(doc("CLASSICMODELS_BD/Customers.xml")//customer), $nl,
  "Número de xecs: ",    count(doc("CLASSICMODELS_BD/Payments.xml")//check)
)
