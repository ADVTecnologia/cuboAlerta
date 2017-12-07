select cemail as DESTMAIL from clientes c

================================================

Prezado Cliente.<p>

    Verificamos em nossos sistemas que constam boleto(s) em aberto com seu CNPJ em nossa empresa. Segue abaixo o(s) mesmo(s) para verificação:<p>

NF: <DESCRI1><p>
OS: <DESCRI2><p>
Nº do documento: <DESCRI3><p>
Vencimento: <DESCRI4><p>
Valor: <DESCRI5><p>

    Caso já tenha realizado a quitação favor desconsiderar este e-mail.<p>

Aguardo retorno.<p>

Att,<p>

Dep. Financeiro.<p>
Brandiet. Com. de Prod. Diet Ltda<p>
Tel.: (41) 3015-8365<p>


========================



select
    c.email as DESTMAIL
    , f.nf as DESCRI1
    , o.os as DESCRI2
    , p.numdocboleto AS DESCRI3
    , p.dtvencto AS DESCRI4
    , p.valor AS DESCRI5
from os o
    join finan f on o.codos = f.codos
    join parcelas p on f.codfin = p.codfin
    join clientes c on o.codcli = c.codcli
where
    p.pago = 'N'
    and p.dtvencto <= current_date - 3
    and o.tipo = 2
    and o.dataosfin is not null
    and p.codtipo = 26
    and coalesce(p.cancelado,0) <> 1