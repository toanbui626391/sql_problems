# Write your MySQL query statement below
with platform_table as(
    select 'mobile' platform
    union
    select 'desktop' platform
    union
    select 'both' platform
),
platform_date as(
    select distinct b.spend_date, a.platform from platform_table a,Spending b
),
user_platform as(
    select user_id,spend_date, 
    case when count(distinct platform)=2 then 'both' else platform end platform,
     sum(amount) total_amount from Spending 
     group by user_id,spend_date
)
select a.spend_date, a.platform, 
ifnull(sum(b.total_amount),0) total_amount, 
count(b.user_id) total_users from platform_date a 
left join user_platform b on a.spend_date = b.spend_date and a.platform = b.platform group by a.spend_date,a.platform