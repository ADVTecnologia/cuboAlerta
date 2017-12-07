select sum(e.qtdeestoque ) - sum(oi.qtde) as "Quantidade em estoque"
from ositenspro oi
    join os o on oi.codos = o.codos
    join estoque e on oi.codpro = e.codpro
where
    (oi.codpro = :codpro)
    and (o.codos = :codos)
having sum(e.qtdeestoque ) - sum(oi.qtde) <=0

