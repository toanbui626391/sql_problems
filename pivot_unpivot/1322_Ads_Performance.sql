/*
problem
    ads (ad_id, user_id, action): action of user on ad. primary key (ad_id, user_id)
    => calculate ctr (click through rate). total_click / total_click + total_view.
    => round 1, order ctr desc, ad_id asc
strategy
    compute total clicked, ignored, viewed for each ad_id
    compute ctl (click through rate)
*/
with temp as (
    select ad_id
    , sum(if(action="Clicked", 1, 0)) as total_clicked
    , sum(if(action="Viewed", 1, 0)) as total_viewed
    , sum(if(action="Ignored", 1, 0)) as total_ignored
    from ads
    group by ad_id
)
select id
if(total_clicked+total_viewed = 0, 0, total_clicked/(total_clicked+total_viewed)) as ctr
from temp

