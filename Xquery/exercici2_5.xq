let $payments := doc("CLASSICMODELS_BD/Payments.xml")/payments/check
let $avg := avg($payments/amount)
for $p in $payments
where number($p/amount) > $avg
order by $p/@number
return $p/@number/string()