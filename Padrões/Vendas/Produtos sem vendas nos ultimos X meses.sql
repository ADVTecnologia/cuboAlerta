---comanado de verificação
select coalesce(pw.valor,0) as VLR1 from PARAMWORKFLOW pw where pw.codwork = 18

--comando auxiliar
select
    cast(substring(p.codigo from 1 for 15) as varchar(15)) as "Código"
    ,cast(substring(p.descricao from 1 for 50) as varchar(50)) as "Descrição"
    ,cast(sum(e.qtdeestoque) as double precision) as "Qtde Estoque"

from produtos p
     join estoque e on e.codpro = p.codpro
where
    -- Caso o item não exista em uma venda
    not exists (select 
                distinct oi.codpro 
            from os o 
                join ositenspro oi on o.codos = oi.codos 
            where 
                (o.tipo=2) 
                -- Verifica tambem se a venda estafechada
                and (o.dataosfin is not null)
                -- Se o codigo do produto esta preenchdi(?)
                and (oi.codpro is not null) 
                -- Codigo do produto igual ao produto contido na OS
                and (p.codpro = oi.codpro)
                -- Verifica a data da OS maior que 1 mês
                and(o.dataos > (current_date - (
                    (select 
                        coalesce(pw.valor,0) 
                    from PARAMWORKFLOW pw 
                    where 
                        (pw.codwork = 18)
                    )*30)))
            )
    and (coalesce(p.cadInativo,0) <> 1)
group by 
    p.codigo, p.descricao
order by 
    p.codigo
