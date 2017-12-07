update finan f2 set f2.nf = (
select
    nf.numnota
    ,f.numlanc
    ,o.os
from notafiscal nf
    join os o on o.codos = nf.codos
    join finan f on f.codos = o.codos
where
    coalesce(nf.anulada,0) = 0
    and nf.protocolonfe is not null
    and coalesce(nf.anulada,0) = 0
    and (o.tipo = 2)
    and coalesce(f.nf,0) = 0
    and coalesce(nf.cancelada,0) = 0
  --  and f2.codfin = f.codfin
    and o.codloja = 1)
    where f2.codfin in(
select
    f2.codfin
from notafiscal nf
    join os o on o.codos = nf.codos
    join finan f on f.codos = o.codos
where
    coalesce(nf.anulada,0) = 0
    and nf.protocolonfe is not null
    and coalesce(nf.anulada,0) = 0
    and (o.tipo = 2)
    and coalesce(f.nf,0) = 0
    and coalesce(nf.cancelada,0) = 0
    and f2.codfin = f.codfin
    and o.codloja = 1
)