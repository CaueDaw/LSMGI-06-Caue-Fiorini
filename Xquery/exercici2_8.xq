let $checks := collection("CLASSICMODELS_BD")//check
let $avg := round(avg($checks/amount))
for $c in $checks
where number($c/amount) > $avg
order by number($c/amount) descending
return concat("Compte: ", $c/@number,
              ", Import: ", $c/amount,
              ", Client: ", $c/customer/customerName)