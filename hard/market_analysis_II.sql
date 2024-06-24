/*
problem
    users (user_id, join_date, favorite_brand)
    order s (user_id, order_date, item_id, buyer_id, seller_id). no seller sole more than one item a date
strategy
    join to get all information, user, order and item
    mark the second sell
    count to mark seller which have only one item sold
*/
with temp as (
    select u.user_id as seller_id
    , i.item_brand as item_brand
    , u.favorite_brand as favorite_brand 
    , row_number() over(partition by u.user_id order by o.order_date) as rnb
    , count(*) over(partition by u.user_id) as cnt
    from users as u
    left join orders as o on u.user_id = o.seller_id
    left join items as i on o.item_id = i.item_id
)
select
seller_id
, if(item_brand=favorite_brand and rnb=2, "yes", "no") as 2nd_item_fav_brand
from temp
where rnb = 2 or cnt=1 -- unique user