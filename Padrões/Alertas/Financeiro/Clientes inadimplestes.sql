select
    cast(substring(c.razao from 1 for 50) as varchar(50)) as "Cliente"
    ,cast(substring(c.fantasia from 1 for 50) as varchar(50)) as "Fantasia"
    ,p.dtvencto as "Vencimento", p.valor as "Valor"

from finan f 
    join parcelas p on p.codfin = f.codfin
    join clientes c on f.codcli = c.codcli
where (p.dtvencto < (current_date - (SELECT PW.VALOR FROM PARAMWORKFLOW PW WHERE PW.CODWORK = 8) ) )
and (p.dtpagto is null)
and (p.cancelado is null)
order by p.dtvencto