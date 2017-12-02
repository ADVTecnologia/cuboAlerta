select
    pc.data as "Data do pedido"
    ,pc.numpedcomp as "Numero do pedido"
    ,pc.previsao as "Previsão do pedido"
    ,f.razao as "Fornecedor"
    ,('R$ ' || cast(pci.totalprd as numeric(10,2))) as "Total do pedido"
from
pedidoscomp pc 
            join pedidoscompitens pci on pc.codpedcomp = pci.codpedcomp
       left join fornecedores f on pc.codfor = f.codfor
            join produtos p on pci.codpro = p.codpro
            join lojas l on l.codloja = pc.codloja
 where pci.qtdenaoentr > 0 and pc.liberado = 1
 and (pc.data) = (current_date - 1)
order by pc.data desc, f.razao, pc.numpedcomp