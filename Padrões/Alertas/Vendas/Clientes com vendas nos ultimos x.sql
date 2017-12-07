/*Seleciona os clientes de forma distinta trazendo apenas clientes com vendas
em uma determinada data*/
select distinct
    c.razao
from os o
    join clientes c on c.codcli = o.codcli
where
    --Estipula o prazo da data
    o.dataosfin between current_date -7 and current_date
    --Considera apenas vendas
    and o.tipo = 2
    --Não traz vendas com valores null(Double check)
    and o.dataosfin is not null
order by
    c.razao asc