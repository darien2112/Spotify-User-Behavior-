With data_set as (SELECT ROW_NUMBER() OVER(ORDER by concat(Age, Gender, spotify_usage_period)) as user_id
        ,* 
FROM dbo.spotify_user)

SELECT user_id, spotify_listening_device, spotify_listening_device_1
        , Case when spotify_listening_device_0 like '%,%' then SUBSTRING(spotify_listening_device_0,CHARINDEX(',', spotify_listening_device_0, 1)+2,len(spotify_listening_device_0))
        else spotify_listening_device_0 end as spotify_listening_device_2
        , Case when spotify_listening_device_0 like '%,%' then LEFT(spotify_listening_device_0,CHARINDEX(',', spotify_listening_device_0, 1)-1)
        else null end as spotify_listening_device_3
FROM
(SELECT user_id, spotify_listening_device
        , Case when spotify_listening_device like '%,%' then SUBSTRING(spotify_listening_device,CHARINDEX(',', spotify_listening_device, 1)+2,len(spotify_listening_device))
        else null end as spotify_listening_device_0
        ,Case when spotify_listening_device like '%,%' then LEFT(spotify_listening_device,CHARINDEX(',', spotify_listening_device, 1)-1)
        else spotify_listening_device end as spotify_listening_device_1
FROM data_set) sub