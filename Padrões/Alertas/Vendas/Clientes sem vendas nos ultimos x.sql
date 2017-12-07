select
    c.razao
    , c.fantasia
    , c.cpcn
    , c.email
    , c.fone1
from clientes c
where codcli not in(
    select distinct
        o.codcli
    from os o
        join clientes c2 on c2.codcli = o.codcli
    where
        --O tipo deve ser uma venda
        o.tipo = 2
        and o.dataosfin is not null
        --Considerando a data de fechamento da OS
        and o.dataosfin between current_date - 7 and current_date
)
order by
     c.razao asc