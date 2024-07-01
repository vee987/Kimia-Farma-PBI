create table kimia_farma.tabel_analisa as (
select 

ft.transaction_id,
ft.date,
ft.branch_id,
kc.branch_name,
kc.kota,
kc.provinsi,
kc.rating as rating_cabang,
ft.customer_name,
ft.product_id,
p.product_name,
ft.price as actual_price,
ft.discount_percentage,
case when ft.price <=50000 then 0.1
    when ft.price <=100000 then 0.15
    when ft.price <=300000 then 0.2
    when ft.price <=500000 then 0.25
    else 0.3
    end as persentase_gross_laba,
ft.price * (1 - ft.discount_percentage) as nett_sales,
ft.price * (1 - ft.discount_percentage) - (ft.price * 
  (1 - case when ft.price <=50000 then 0.1
            when ft.price <=100000 then 0.15
            when ft.price <=300000 then 0.2
            when ft.price <=500000 then 0.25
            else 0.3
            end)) as nett_profit,    
ft.rating as rating_transaksi

from kimia_farma.kf_final_transaction as ft

left join kimia_farma.kf_kantor_cabang as kc
on ft.branch_id = kc.branch_id

left join kimia_farma.kf_product as p
on ft.product_id = p.product_id
);