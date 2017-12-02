select 
l.loja as "Loja     "
,pc.numpedcomp as "Nº Pedido     "
,pc.data as "Data do Pedido     "
,pc.previsao as "Previsão     "
,cast(substring(f.razao from 1 for 50) as varchar(50)) as "Fornecedor"
,cast(substring(p.codigo from 1 for 15) as varchar(25)) as "Código"
,cast(substring(p.descricao from 1 for 50) as varchar(50)) || coalesce(cast(substring(pci.obs from 1 for 50) as varchar(50)),'') as "Descrição"
,cast(pci.qtde as double precision) as "     Qtde Pedida"
,sum(cast(coalesce(pce.qtde,0) as double precision)) as "     Qtde Entregue"
,sum(((     select 
           sum(pci2.qtde)  
        from pedidoscompitens pci2 
        where 
            pci.codpedcomp = pci2.codpedcomp 
            and pci.codpro = pci2.codpro 
            and pci.numitem = pci2.numitem) - coalesce((
                                                        select 
                                                           sum(pc2.qtde)  
                                                        from entradaitens pc2
                                                        where 
                                                            (pc2.codent = pce.codent) 
                                                            and (pc2.codpedcomp = pci.codpedcomp) 
                                                            and (pc2.numitempedcomp = pci.numitem)),0))) as "Qtde Pendente"

from pedidoscomp pc
    join pedidoscompitens pci on pc.codpedcomp = pci.codpedcomp
    left join fornecedores f on pc.codfor = f.codfor
    join produtos p on pci.codpro = p.codpro
    left join entradaitens pce on ((pce.codpedcomp = pci.codpedcomp) and (pce.numitempedcomp = pci.numitem))
    left join entradas e on e.codent = pce.codent
    join lojas l on l.codloja = pc.codloja
where 
    (pc.previsao < current_date) 
    and ((
        select 
            pci2.qtde 
        from pedidoscompitens pci2 
        where 
            pci.codpedcomp = pci2.codpedcomp 
            and pci.codpro = pci2.codpro 
            and pci.numitem = pci2.numitem) - coalesce((
                select 
                    pc2.qtde 
                from entradaitens pc2
                where 
                    (pc2.codent = pce.codent) 
                    and (pc2.codpedcomp = pci.codpedcomp) 
                    and (pc2.numitempedcomp = pci.numitem)),0)) > 0
group by 1,2,3,4,5,6,7,8
having(sum(cast(coalesce(pce.qtde,0) as double precision))) <> sum(((     select
           sum(pci2.qtde)  
        from pedidoscompitens pci2 
        where 
            pci.codpedcomp = pci2.codpedcomp 
            and pci.codpro = pci2.codpro 
            and pci.numitem = pci2.numitem) - coalesce((
                                                        select 
                                                           sum(pc2.qtde)  
                                                        from entradaitens pc2
                                                        where 
                                                            (pc2.codent = pce.codent) 
                                                            and (pc2.codpedcomp = pci.codpedcomp) 
                                                            and (pc2.numitempedcomp = pci.numitem)),0)))