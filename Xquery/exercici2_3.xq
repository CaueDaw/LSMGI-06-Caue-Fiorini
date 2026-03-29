let $payments := doc("CLASSICMODELS_BD/Payments.xml")/payments/check
return sum(
  $payments[customer/salesRepEmployeeNumber = 1370]/amount
)