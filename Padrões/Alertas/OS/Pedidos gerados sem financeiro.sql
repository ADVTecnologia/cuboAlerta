select o.os
    from os o
       left join finan f on f.codos = o.codos
    where (o.dataos = current_date)
        and (o.dataosfin is not null)
        and (f.codos is null)
        and (o.tipo = 2)