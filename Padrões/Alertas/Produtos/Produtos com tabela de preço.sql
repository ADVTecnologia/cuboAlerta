select
     prod.descricao as descricaoproduto
    ,pt.DESCRICAO as descricaotabela
    ,prod.precotabela
    ,prod.precovenda
    ,prod.precominimo
    ,pti.v1
    ,pti.v2
    ,pti.v3
    ,pti.v4
    ,pti.v5
    ,pti.v6
    ,pti.v7
    ,pti.v8
    ,pti.v9
    ,pti.v10
from produtos prod
    join prodtabelasitens pti on pti.codpro = prod.codpro
    join prodtabelas pt on pt.CODPRODTABELA = pti.CODPRODTABELA

