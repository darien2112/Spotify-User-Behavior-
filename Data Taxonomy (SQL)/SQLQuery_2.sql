With data_set as (select ROW_NUMBER() OVER(ORDER by concat(Age, Gender, spotify_usage_period)) as user_id
        , *
from dbo.spotify_user)

select user_id
        , case when spotify_subscription_plan = 'Free (ad-supported)' 
                    and premium_sub_willingness = 'Yes'
                    then 'Free user and will upgrade plan'
                when spotify_subscription_plan = 'Free (ad-supported)' 
                    and premium_sub_willingness = 'No'
                    then 'Free user and no plan upgrade'
                when spotify_subscription_plan = 'Premium (paid subscription)' 
                    and premium_sub_willingness = 'Yes'
                    then 'Users pay and continue to subscribe'
            else 'Paid users and will not continue to subscribe' 
            end as user_cate
from data_set